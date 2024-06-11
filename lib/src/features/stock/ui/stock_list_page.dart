import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/features/stock/ui/widgets/product_dialog.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/features/stock/ui/widgets/inventory_item.dart';
import 'package:pind_app/src/features/stock/interactor/blocs/product_bloc.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';
import 'package:pind_app/src/features/stock/interactor/events/product_event.dart';
import 'package:pind_app/src/features/stock/interactor/states/product_state.dart';
import 'package:uuid/uuid.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  final _bloc = getIt<ProductBloc>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllProductsEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _nameController.clear();
    _quantityController.clear();
  }

  void _addOrEditProduct(
    BuildContext context, {
    String? productId,
  }) {
    showDialog(
      context: context,
      builder: (context) => ProductDialog(
        title: productId == null ? "Novo Produto" : "Editar Produto",
        productName: "Nome",
        productHintText: "Nome do produto",
        productFieldController: _nameController,
        quantity: "Quantidade",
        quantityHintText: "Quantidade (kg)",
        quantityFieldController: _quantityController,
        primaryButtonText: productId == null ? "Adicionar" : "Editar",
        secondaryButtonText: "Cancelar",
        onPrimaryButtonTapped: () {
          final name = _nameController.text;
          final quantity = _quantityController.text;
          if (productId != null) {
            _bloc.add(
              UpdateProductEvent(
                id: productId,
                updatedProduct: ProductEntity(
                  id: productId,
                  name: name,
                  quantity: quantity,
                ),
              ),
            );
          } else {
            _bloc.add(
              AddProductEvent(
                product: ProductEntity(
                  id: const Uuid().v1(),
                  name: name,
                  quantity: quantity,
                ),
              ),
            );
          }
          context.pop();
          _clearTextFields();
          _bloc.add(GetAllProductsEvent());
        },
        onSecondaryButtonTapped: () {
          context.pop();
          _clearTextFields();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingProductState) {
            return Center(
              child: CustomProgressIndicator(
                color: theme.colorScheme.tertiary,
              ),
            );
          } else if (state is LoadedProductState) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (ctx, index) {
                final product = state.products[index];
                return InventoryItem(
                  name: product.name,
                  quantity: double.parse(product.quantity),
                  onEdit: (BuildContext context) {
                    _nameController.text = product.name;
                    _quantityController.text = product.quantity;
                    _addOrEditProduct(
                      context,
                      productId: product.id,
                    );
                  },
                  onRemove: (BuildContext context) {
                    _bloc.add(RemoveProductEvent(id: product.id!));
                    _bloc.add(GetAllProductsEvent());
                  },
                );
              },
            );
          } else if (state is ErrorProductState) {
            final message = state.message;

            return Center(
              child: Text(
                message,
                style: AppTextStyles.medium14,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditProduct(context),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

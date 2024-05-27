import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_dialog.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/common/widgets/inventory_item.dart';
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
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllProductsEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _addOrEditProduct({String? id}) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: id == null ? "Novo Produto" : "Editar Produto",
        firstFieldName: "Nome",
        firstFieldHintText: "Nome do produto",
        firstFieldController: _nameController,
        secondFieldName: "Quantidade",
        secondFieldHintText: "Quantidade (kg)",
        secondFieldController: _quantityController,
        thirdFieldName: "Categoria",
        thirdFieldHintText: "Categoria do produto",
        thirdFieldController: _categoryController,
        primaryButtonText: id == null ? "Adicionar" : "Editar",
        secondaryButtonText: "Cancelar",
        onPrimaryButtonTapped: () {
          final name = _nameController.text;
          final quantity = _quantityController.text;
          final category = _categoryController.text;

          if (id == null) {
            _bloc.add(
              AddProductEvent(
                product: ProductEntity(
                  id: const Uuid().v1(),
                  name: name,
                  quantity: quantity,
                  category: category,
                ),
              ),
            );
          } else {
            _bloc.add(
              UpdateProductEvent(
                id: id,
                updatedProduct: ProductEntity(
                  name: name,
                  quantity: quantity,
                  category: category,
                ),
              ),
            );
          }

          _bloc.add(GetAllProductsEvent());
          context.pop();
          _clearTextFields();
        },
        onSecondaryButtonTapped: () {
          context.pop();
          _clearTextFields();
        },
      ),
    );
  }

  void _clearTextFields() {
    _nameController.clear();
    _quantityController.clear();
    _categoryController.clear();
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
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (ctx, index) {
                    final product = state.products[index];
                    return InventoryItem(
                      name: product.name!,
                      quantity: double.parse(product.quantity!),
                      onEdit: (context) {
                        _nameController.text = product.name!;
                        _quantityController.text = product.quantity!;
                        _categoryController.text = product.category!;
                        _addOrEditProduct(id: product.id);
                      },
                      onRemove: (context) {
                        _bloc.add(RemoveProductEvent(id: product.id!));
                      },
                    );
                  },
                ),
              ],
            );
          } else if (state is ErrorProductState) {
            return Center(
              child: Text(
                "Erro ao carregar a lista de produtos: ${state.message}",
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Nenhum produto encontrado",
                style: AppTextStyles.medium14,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditProduct(),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

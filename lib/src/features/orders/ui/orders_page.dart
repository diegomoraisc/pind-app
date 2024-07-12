import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/features/orders/interactor/blocs/order_bloc.dart';
import 'package:pind_app/src/features/orders/interactor/entities/order_entity.dart';
import 'package:pind_app/src/features/orders/interactor/events/order_event.dart';
import 'package:pind_app/src/features/orders/interactor/states/order_state.dart';
import 'package:pind_app/src/features/orders/ui/widgets/order_expansion_tile.dart';
import 'package:pind_app/src/features/orders/ui/widgets/order_form.dart';

import 'package:uuid/uuid.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final _bloc = getIt.get<OrderBloc>();
  final _quantityController = TextEditingController();
  String? _selectedProductId;
  String? _selectedCustomerId;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllOrdersEvent());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingOrderState) {
            return Center(
              child: CustomProgressIndicator(
                color: theme.colorScheme.tertiary,
              ),
            );
          } else if (state is LoadedOrderState) {
            state.orders.sort((a, b) => b.date.compareTo(a.date));

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderExpansionTile(
                  title: order.id!.substring(0, 8),
                  subtitle: FutureBuilder<String>(
                    future: _bloc.getCustomerName(order.customerId),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? 'Cliente não encontrado',
                        style: theme.textTheme.titleSmall,
                      );
                    },
                  ),
                  product: FutureBuilder<String>(
                    future: _bloc.getProductName(order.productId),
                    builder: (context, snapshot) {
                      return Text.rich(
                        TextSpan(
                          text: "Produto: ",
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: snapshot.data ?? 'Produto não encontrado',
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  quantity: order.quantity.toString(),
                  orderDate: DateFormat('dd/MM/yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(order.date),
                  ),
                  onRemove: (context) {
                    _bloc.add(RemoveOrderEvent(id: order.id!));
                  },
                );
              },
            );
          } else if (state is ErrorOrderState) {
            final message = state.message;

            return Center(
              child: Text(
                message,
                style: theme.textTheme.titleSmall,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => OrderForm(
              title: "Novo Pedido",
              quantity: "Quantidade",
              quantityHintText: "Quantidade (kg)",
              quantityFieldController: _quantityController,
              primaryButtonText: "Adicionar",
              secondaryButtonText: "Cancelar",
              onProductSelected: (productId) {
                _selectedProductId = productId;
              },
              onCustomerSelected: (customerId) {
                _selectedCustomerId = customerId;
              },
              onPrimaryButtonTapped: () {
                if (_selectedProductId != null && _selectedCustomerId != null) {
                  _bloc.add(
                    AddOrderEvent(
                      order: OrderEntity(
                        id: const Uuid().v4(),
                        productId: _selectedProductId!,
                        customerId: _selectedCustomerId!,
                        quantity: int.parse(_quantityController.text),
                        date: DateTime.now().millisecondsSinceEpoch,
                      ),
                    ),
                  );
                  context.pop();
                  _quantityController.clear();
                  _bloc.add(GetAllOrdersEvent());
                }
              },
              onSecondaryButtonTapped: () {
                context.pop();
                _quantityController.clear();
              },
            ),
          );
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

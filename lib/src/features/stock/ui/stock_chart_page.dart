import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/features/customers/interactor/blocs/customer_bloc.dart';
import 'package:pind_app/src/features/customers/interactor/events/customer_event.dart';
import 'package:pind_app/src/features/customers/interactor/states/customer_state.dart';
import 'package:pind_app/src/features/orders/interactor/blocs/order_bloc.dart';
import 'package:pind_app/src/features/orders/interactor/events/order_event.dart';
import 'package:pind_app/src/features/orders/interactor/states/order_state.dart';
import 'package:pind_app/src/features/stock/ui/widgets/chart_info_card.dart';
import 'package:pind_app/src/features/stock/ui/widgets/chart_info_card_item.dart';
import 'package:pind_app/src/features/stock/ui/widgets/stock_chart.dart';
import 'package:pind_app/src/features/stock/interactor/blocs/product_bloc.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';
import 'package:pind_app/src/features/stock/interactor/events/product_event.dart';
import 'package:pind_app/src/features/stock/interactor/states/product_state.dart';

class StockChartPage extends StatefulWidget {
  const StockChartPage({super.key});

  @override
  State<StockChartPage> createState() => _StockChartPageState();
}

class _StockChartPageState extends State<StockChartPage> {
  final _productBloc = getIt.get<ProductBloc>();
  final _clientBloc = getIt.get<CustomerBloc>();
  final _orderBloc = getIt.get<OrderBloc>();
  int? touchedIndex;
  String? productName;
  double? productQuantity;
  List<ProductEntity> products = [];
  double totalQuantity = 0.0;
  int clientCount = 0;
  int ordersCount = 0;

  @override
  void initState() {
    super.initState();
    _productBloc.add(GetAllProductsEvent());
    _clientBloc.add(GetAllCustomersEvent());
    _orderBloc.add(GetAllOrdersEvent());
  }

  void _updateClientCount(int count) {
    Future.microtask(() {
      setState(() {
        clientCount = count;
      });
    });
  }

  void _updateProducts(List<ProductEntity> newProducts) {
    Future.microtask(() {
      setState(() {
        products = newProducts;
        totalQuantity = products.isNotEmpty
            ? products
                .map((product) => double.tryParse(product.quantity) ?? 0.0)
                .reduce((value, element) => value + element)
            : 0.0;
      });
    });
  }

  void _updateOrdersCount(int count) {
    Future.microtask(() {
      setState(() {
        ordersCount = count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductBloc, ProductState>(
            bloc: _productBloc,
            listener: (context, state) {
              if (state is LoadedProductState) {
                _updateProducts(state.products);
              }
            },
          ),
          BlocListener<CustomerBloc, CustomerState>(
            bloc: _clientBloc,
            listener: (context, state) {
              if (state is LoadedCustomerState) {
                _updateClientCount(state.customers.length);
              }
            },
          ),
          BlocListener<OrderBloc, OrderState>(
            bloc: _orderBloc,
            listener: (context, state) {
              if (state is LoadedOrderState) {
                _updateOrdersCount(state.orders.length);
              }
            },
          ),
        ],
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: _productBloc,
          builder: (context, state) {
            if (state is LoadingProductState) {
              return Center(
                child: CustomProgressIndicator(
                  color: theme.colorScheme.tertiary,
                ),
              );
            } else if (state is LoadedProductState) {
              _updateProducts(state.products);
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    StockChart(
                      products: products,
                      touchedIndex: touchedIndex,
                      productName: productName,
                      productQuantity: productQuantity,
                      onSectionTouched: (index) {
                        setState(
                          () {
                            touchedIndex = index;
                            if (index != null &&
                                index >= 0 &&
                                index < products.length) {
                              productName = products[index].name;
                              productQuantity =
                                  double.tryParse(products[index].quantity) ??
                                      0.0;
                            } else {
                              productName = null;
                              productQuantity = null;
                            }
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        children: [
                          ChartInfoCard(
                            children: [
                              ChartInfoCardItem(
                                title: "Produtos",
                                subTitle: products.length.toString(),
                                icon: FontAwesomeIcons.appleWhole,
                              ),
                              ChartInfoCardItem(
                                title: "Total em estoque (kg)",
                                subTitle: totalQuantity.toStringAsFixed(1),
                                icon: FontAwesomeIcons.weightHanging,
                              ),
                            ],
                          ),
                          ChartInfoCard(
                            children: [
                              ChartInfoCardItem(
                                title: "Clientes",
                                subTitle: clientCount.toString(),
                                icon: FontAwesomeIcons.list,
                              ),
                              ChartInfoCardItem(
                                title: "Pedidos",
                                subTitle: ordersCount.toString(),
                                icon: FontAwesomeIcons.truckFast,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
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
  final _bloc = getIt.get<ProductBloc>();
  int? touchedIndex;
  String? productName;
  double? productQuantity;
  List<ProductEntity> products = [];
  double totalQuantity = 0.0;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllProductsEvent());
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingProductState) {
              return Center(
                child: CustomProgressIndicator(
                  color: theme.colorScheme.tertiary,
                ),
              );
            } else if (state is LoadedProductState) {
              _updateProducts(state.products);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StockChart(
                    products: products,
                    touchedIndex: touchedIndex,
                    productName: productName,
                    productQuantity: productQuantity,
                    onSectionTouched: (index) {
                      setState(() {
                        touchedIndex = index;
                        if (index != null &&
                            index >= 0 &&
                            index < products.length) {
                          productName = products[index].name;
                          productQuantity =
                              double.tryParse(products[index].quantity) ?? 0.0;
                        } else {
                          productName = null;
                          productQuantity = null;
                        }
                      });
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
                            const ChartInfoCardItem(
                              title: "Clientes",
                              subTitle: "0",
                              icon: FontAwesomeIcons.list,
                            ),
                          ],
                        ),
                        ChartInfoCard(
                          children: [
                            ChartInfoCardItem(
                              title: "Total em estoque (kg)",
                              subTitle: totalQuantity.toStringAsFixed(1),
                              icon: FontAwesomeIcons.weightHanging,
                            ),
                            const ChartInfoCardItem(
                              title: "Pedidos",
                              subTitle: "0",
                              icon: FontAwesomeIcons.truckFast,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("Nenhum produto encontrado"),
              );
            }
          },
        ),
      ),
    );
  }
}

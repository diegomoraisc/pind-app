import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pind_app/src/common/widgets/chart_info_card.dart';
import 'package:pind_app/src/common/widgets/chart_info_card_item.dart';
import 'package:pind_app/src/common/widgets/product_info_chart.dart';

class StockChartPage extends StatefulWidget {
  const StockChartPage({super.key});

  @override
  State<StockChartPage> createState() => _StockChartPageState();
}

class _StockChartPageState extends State<StockChartPage> {
  int touchedIndex = -1;
  String? categoryName;
  double? categoryProductsQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Stack(
                children: [
                  Center(
                    child: ProductInfoChart(
                      categoryName: categoryName ?? "",
                      totalQuantityCategory: categoryProductsQuantity ?? 0.0,
                    ),
                  ),
                  loadChart(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  ChartInfoCard(
                    children: [
                      ChartInfoCardItem(
                        title: "Produtos",
                        subTitle: "1",
                        icon: FontAwesomeIcons.appleWhole,
                      ),
                      ChartInfoCardItem(
                        title: "Categorias",
                        subTitle: "1",
                        icon: FontAwesomeIcons.list,
                      ),
                    ],
                  ),
                  ChartInfoCard(
                    children: [
                      ChartInfoCardItem(
                        title: "Total em estoque (kg)",
                        subTitle: "120",
                        icon: FontAwesomeIcons.weightHanging,
                      ),
                      ChartInfoCardItem(
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
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
      (index) {
        final isTouched = index == touchedIndex;
        final radius = isTouched ? 30.0 : 20.0;
        final color =
            isTouched ? const Color(0xFF6EAC5D) : const Color(0xFF8ED87A);
        return PieChartSectionData(
          color: color,
          title: "Frutas",
          value: 120,
          showTitle: false,
          radius: radius,
        );
      },
    );
  }

  PieChart loadChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(
              () {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
                if (touchedIndex != -1) {
                  categoryName = showingSections()[touchedIndex].title;
                  categoryProductsQuantity =
                      showingSections()[touchedIndex].value;
                }
              },
            );
          },
        ),
        sectionsSpace: 1.5,
        sections: showingSections(),
      ),
    );
  }
}

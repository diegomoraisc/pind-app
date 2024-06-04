import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pind_app/src/features/stock/ui/widgets/product_info_chart.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

class StockChart extends StatelessWidget {
  final List<ProductEntity> products;
  final int? touchedIndex;
  final String? productName;
  final double? productQuantity;
  final ValueChanged<int?> onSectionTouched;

  const StockChart({
    Key? key,
    required this.products,
    this.touchedIndex,
    this.productName,
    this.productQuantity,
    required this.onSectionTouched,
  }) : super(key: key);

  List<PieChartSectionData> _buildSections() {
    return products.asMap().entries.map((entry) {
      int index = entry.key;
      ProductEntity product = entry.value;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 30.0 : 20.0;
      final color =
          isTouched ? const Color(0xFF6EAC5D) : const Color(0xFF8ED87A);
      return PieChartSectionData(
        color: color,
        title: product.name,
        value: double.tryParse(product.quantity) ?? 0.0,
        showTitle: false,
        radius: radius,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Stack(
        children: [
          Center(
            child: ProductInfoChart(
              productName: productName ?? "",
              productQuantity: productQuantity ?? 0.0,
            ),
          ),
          PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    onSectionTouched(null);
                  } else {
                    final index =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                    onSectionTouched(index);
                  }
                },
              ),
              sectionsSpace: 1.5,
              sections: _buildSections(),
            ),
          ),
        ],
      ),
    );
  }
}

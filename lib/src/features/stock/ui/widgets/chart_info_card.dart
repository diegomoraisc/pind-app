import 'package:flutter/material.dart';
import 'package:pind_app/src/features/stock/ui/widgets/chart_info_card_item.dart';

class ChartInfoCard extends StatelessWidget {
  final List<ChartInfoCardItem> children;
  const ChartInfoCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children,
      ),
    );
  }
}

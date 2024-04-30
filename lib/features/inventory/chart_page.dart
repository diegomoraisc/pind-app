import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pind_app/widgets/chart_card_item.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    startDegreeOffset: 10,
                    sections: [
                      PieChartSectionData(
                        value: 120,
                        title: 'Frutas',
                        showTitle: false,
                        radius: 35,
                        color: Colors.purple,
                      ),
                      PieChartSectionData(
                        value: 120,
                        title: 'Frutas',
                        showTitle: false,
                        radius: 35,
                        color: Colors.purple,
                      ),
                      PieChartSectionData(
                        value: 120,
                        title: 'Frutas',
                        showTitle: false,
                        radius: 35,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const ChartCardItem(
              name: "Frutas",
              percentage: "100%",
            ),
          ],
        ),
      ),
    );
  }
}

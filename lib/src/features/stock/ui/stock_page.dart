import 'package:flutter/material.dart';

import 'stock_chart_page.dart';
import 'stock_list_page.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.bar_chart_rounded),
          ),
          Tab(
            icon: Icon(Icons.inventory_2_rounded),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: ColoredBox(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  StockChartPage(),
                  StockListPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

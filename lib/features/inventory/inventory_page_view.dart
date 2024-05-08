import 'package:flutter/material.dart';
import 'package:pind_app/features/chart/chart_page.dart';
import 'package:pind_app/features/inventory/inventory_page.dart';

class InventoryPageView extends StatefulWidget {
  const InventoryPageView({super.key});

  @override
  State<InventoryPageView> createState() => _InventoryPageViewState();
}

class _InventoryPageViewState extends State<InventoryPageView> {
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
                  ChartPage(),
                  InventoryPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

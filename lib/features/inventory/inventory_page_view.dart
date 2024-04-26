import 'package:flutter/material.dart';
import 'package:pind_app/features/inventory/chart_page.dart';
import 'package:pind_app/features/inventory/inventory_page.dart';
import 'package:pind_app/widgets/slidable_menu.dart';
import 'package:pind_app/widgets/slidable_menu_item.dart';

class InventoryPageView extends StatefulWidget {
  const InventoryPageView({super.key});

  @override
  State<InventoryPageView> createState() => _InventoryPageViewState();
}

class _InventoryPageViewState extends State<InventoryPageView> {
  final _pageController = PageController();
  int _currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SlidableMenu(
            children: [
              SlidableMenuItem(
                onPressed: () {
                  _onNavItemTapped(0);
                },
                icon: Icons.inventory_2_rounded,
                iconColor: _currentPageIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[350]!,
                color: _currentPageIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
              ),
              SlidableMenuItem(
                onPressed: () => _onNavItemTapped(1),
                icon: Icons.bar_chart_rounded,
                iconColor: _currentPageIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[350]!,
                color: _currentPageIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                InventoryPage(), // Primeira página
                ChartPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

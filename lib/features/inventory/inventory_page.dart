import 'package:flutter/material.dart';
import 'package:pind_app/widgets/inventory_item.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return InventoryItem(
                  name: "Banana",
                  quantity: 120,
                  onEdit: (context) {},
                  onRemove: (context) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

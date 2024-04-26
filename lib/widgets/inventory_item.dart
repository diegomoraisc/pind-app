import 'package:flutter/material.dart';

class InventoryItem extends StatefulWidget {
  final String name;
  final double quantity;
  const InventoryItem({
    Key? key,
    required this.name,
    required this.quantity,
  }) : super(key: key);

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  double _quantity = 0.0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void updateQuantity(double newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
  }

  Color stockColor(double quantity) {
    if (quantity > 100) {
      return const Color(0xFF3C7B2F);
    } else if (quantity > 30) {
      return Colors.amber.shade300;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        bottom: 15,
        left: 20,
      ),
      child: SizedBox(
        height: 100,
        child: Card(
          elevation: 2,
          color: Colors.white,
          child: Center(
            child: ListTile(
              leading: Container(
                height: 40,
                width: 7,
                decoration: BoxDecoration(
                  color: stockColor(_quantity),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              title: Text(
                widget.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: Theme.of(context).colorScheme.primary),
              ),
              subtitle: Text(
                "${widget.quantity.toStringAsFixed(1)} (kg)",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class InventoryItem extends StatefulWidget {
  final String name;
  final double quantity;
  final void Function(BuildContext) onEdit;
  final void Function(BuildContext) onRemove;
  const InventoryItem({
    Key? key,
    required this.name,
    required this.quantity,
    required this.onEdit,
    required this.onRemove,
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
        top: 10,
        right: 20,
        bottom: 10,
        left: 20,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              onPressed: widget.onEdit,
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              onPressed: widget.onRemove,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade600,
            ),
          ],
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
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

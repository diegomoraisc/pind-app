import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StockItem extends StatefulWidget {
  final String name;
  final double quantity;
  final void Function(BuildContext) onEdit;
  final void Function(BuildContext) onRemove;
  const StockItem({
    Key? key,
    required this.name,
    required this.quantity,
    required this.onEdit,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<StockItem> createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
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
      return Theme.of(context).colorScheme.primary;
    } else if (quantity > 30) {
      return Colors.amber.shade300;
    } else if (quantity >= 1) {
      return Theme.of(context).colorScheme.error;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(12);

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        bottom: 10,
        left: 20,
      ),
      child: Card(
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned.fill(
              child: Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: borderRadius,
                  ),
                ),
              ),
            ),
            Slidable(
              key: UniqueKey(),
              direction: Axis.horizontal,
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: widget.onEdit,
                    icon: Icons.edit,
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                  ),
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    onPressed: widget.onRemove,
                    icon: Icons.delete,
                    foregroundColor: theme.colorScheme.error,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
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
                      style: theme.textTheme.titleLarge!.apply(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    subtitle: Text(
                      "${widget.quantity.toStringAsFixed(1)} (kg)",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

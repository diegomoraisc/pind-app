import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pind_app/src/common/constants/app_colors.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

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
      return AppColors.primary;
    } else if (quantity > 30) {
      return Colors.amber.shade300;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(12);

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
                    foregroundColor: Colors.red,
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
                      style: AppTextStyles.semiBold20.apply(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    subtitle: Text(
                      "${widget.quantity.toStringAsFixed(1)} (kg)",
                      style: AppTextStyles.medium14,
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

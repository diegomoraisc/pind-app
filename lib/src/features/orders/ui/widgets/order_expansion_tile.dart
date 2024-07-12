import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderExpansionTile extends StatefulWidget {
  final String title;
  final Widget subtitle;
  final Widget product;
  final String quantity;
  final String orderDate;
  final Widget? trailing;
  final void Function(BuildContext) onRemove;

  const OrderExpansionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.product,
    required this.quantity,
    required this.orderDate,
    required this.onRemove,
    this.trailing,
  });

  @override
  State<OrderExpansionTile> createState() => _OrderExpansionTileState();
}

class _OrderExpansionTileState extends State<OrderExpansionTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(12.0);

    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 20, right: 20, bottom: 7),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Theme(
          data: theme.copyWith(
            dividerColor: Colors.transparent,
          ),
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
                child: ExpansionTile(
                  title: RichText(
                    text: TextSpan(
                      text: "Pedido",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 18,
                        color: Colors.grey[850],
                      ),
                      children: [
                        TextSpan(
                          text: " #${widget.title}",
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: widget.subtitle,
                  children: [
                    ListTile(
                      title: Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: widget.product),
                      subtitle: RichText(
                        text: TextSpan(
                          text: "Quantidade: ",
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: "${widget.quantity} (kg)",
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: "Data do pedido: ",
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: widget.orderDate.toString(),
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

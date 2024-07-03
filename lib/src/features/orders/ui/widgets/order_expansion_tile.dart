import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class OrderExpansionTile extends StatefulWidget {
  final String title;
  final Widget subtitle;
  final Widget product;
  final String quantity;
  final String orderDate;

  const OrderExpansionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.product,
    required this.quantity,
    required this.orderDate,
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
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Theme(
          data: theme.copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text(
              widget.title,
              style: AppTextStyles.semiBold20.copyWith(
                fontSize: 18,
              ),
            ),
            subtitle: widget.subtitle,
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: widget.product
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: "Quantidade: ",
                    style: AppTextStyles.semiBold20.copyWith(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "${widget.quantity} (kg)",
                        style: AppTextStyles.medium14.copyWith(
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
                    style: AppTextStyles.semiBold20.copyWith(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: widget.orderDate.toString(),
                        style: AppTextStyles.medium14.copyWith(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class ProductInfoChart extends StatelessWidget {
  final String productName;
  final double productQuantity;
  const ProductInfoChart({
    Key? key,
    required this.productName,
    required this.productQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVisible = productName.isNotEmpty && productQuantity > 0.0;

    BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 2.5,
          spreadRadius: .5,
          offset: const Offset(0, 1.5),
        ),
      ],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        minHeight: isVisible ? 150 : 0,
        minWidth: isVisible ? 150 : 0,
      ),
      decoration: isVisible ? boxDecoration : null,
      child: isVisible
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productName,
                  style: AppTextStyles.semiBold20,
                ),
                Text(
                  "${productQuantity.toStringAsFixed(0)} kg",
                  style: AppTextStyles.medium14,
                ),
              ],
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class ProductInfoChart extends StatelessWidget {
  final String categoryName;
  final double totalQuantityCategory;
  const ProductInfoChart({
    super.key,
    required this.categoryName,
    required this.totalQuantityCategory,
  });

  @override
  Widget build(BuildContext context) {
    bool isVisible =
        categoryName.isNotEmpty && totalQuantityCategory > 0.0 ? true : false;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        minHeight: isVisible ? 150 : 0,
        minWidth: isVisible ? 150 : 0,
      ),
      decoration: BoxDecoration(
        color: isVisible ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: isVisible
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2.5,
                  spreadRadius: .5,
                  offset: const Offset(0, 1.5),
                ),
              ]
            : [],
      ),
      child: isVisible
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryName,
                  style: AppTextStyles.semiBold20,
                ),
                Text(
                  "${totalQuantityCategory.toStringAsFixed(0)} kg",
                  style: AppTextStyles.medium14,
                ),
              ],
            )
          : null,
    );
  }
}

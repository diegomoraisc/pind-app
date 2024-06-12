import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_colors.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

class ProductForm extends StatelessWidget {
  final String title;
  final String primaryButtonText;
  final String secondaryButtonText;
  final String productName;
  final String productHintText;
  final TextEditingController productFieldController;
  final String quantity;
  final String quantityHintText;
  final TextEditingController quantityFieldController;
  final VoidCallback? onPrimaryButtonTapped;
  final VoidCallback? onSecondaryButtonTapped;
  const ProductForm({
    super.key,
    required this.title,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.productName,
    required this.productHintText,
    required this.quantity,
    required this.quantityHintText,
    required this.productFieldController,
    required this.quantityFieldController,
    this.onPrimaryButtonTapped,
    this.onSecondaryButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(title.toUpperCase(), style: AppTextStyles.medium14),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: productFieldController,
                    fieldName: productName,
                    hintText: productHintText,
                    borderColor: AppColors.grey,
                  ),
                  CustomTextFormField(
                    controller: quantityFieldController,
                    fieldName: quantity,
                    hintText: quantityHintText,
                    borderColor: AppColors.grey,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFC4C4C4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onSecondaryButtonTapped,
                    child: Text(
                      secondaryButtonText,
                      style: AppTextStyles.medium14.apply(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onPrimaryButtonTapped,
                      child: Text(
                        primaryButtonText,
                        style:
                            AppTextStyles.medium14.apply(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

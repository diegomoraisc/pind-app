import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_colors.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String primaryButtonText;
  final String secondaryButtonText;
  final String firstFieldName;
  final String firstFieldHintText;
  final TextEditingController firstFieldController;
  final String secondFieldName;
  final String secondFieldHintText;
  final TextEditingController secondFieldController;
  final VoidCallback? onPrimaryButtonTapped;
  final VoidCallback? onSecondaryButtonTapped;
  const CustomDialog({
    super.key,
    required this.title,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.firstFieldName,
    required this.firstFieldHintText,
    required this.secondFieldName,
    required this.secondFieldHintText,
    required this.firstFieldController,
    required this.secondFieldController,
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
                    controller: firstFieldController,
                    fieldName: firstFieldName,
                    hintText: firstFieldHintText,
                    borderColor: AppColors.grey,
                  ),
                  CustomTextFormField(
                    controller: secondFieldController,
                    fieldName: secondFieldName,
                    hintText: secondFieldHintText,
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

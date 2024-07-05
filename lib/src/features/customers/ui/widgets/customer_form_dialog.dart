import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_colors.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

class CustomerForm extends StatelessWidget {
  final String title;
  final String customerName;
  final String nameHintText;
  final TextEditingController nameFieldController;
  final String cnpj;
  final String cnpjHintText;
  final TextEditingController cnpjFieldController;
  final String customerAdress;
  final String adressHintText;
  final TextEditingController adressFieldController;
  final String customerEmail;
  final String emailHintText;
  final TextEditingController emailFieldController;
  final String customerPhoneNumber;
  final String phoneNumberHintText;
  final TextEditingController phoneNumberFieldController;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback? onPrimaryButtonTapped;
  final VoidCallback? onSecondaryButtonTapped;

  const CustomerForm({
    super.key,
    required this.title,
    required this.customerName,
    required this.nameHintText,
    required this.nameFieldController,
    required this.cnpj,
    required this.cnpjHintText,
    required this.cnpjFieldController,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.customerAdress,
    required this.adressHintText,
    required this.adressFieldController,
    required this.phoneNumberHintText,
    required this.customerEmail,
    required this.emailHintText,
    required this.emailFieldController,
    required this.customerPhoneNumber,
    required this.phoneNumberFieldController,
    this.onPrimaryButtonTapped,
    this.onSecondaryButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              title.toUpperCase(),
              style: AppTextStyles.medium14,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: nameFieldController,
                      fieldName: customerName,
                      hintText: nameHintText,
                      borderColor: AppColors.grey,
                    ),
                    CustomTextFormField(
                      controller: cnpjFieldController,
                      keyboardType: TextInputType.number,
                      fieldName: cnpj,
                      hintText: cnpjHintText,
                      borderColor: AppColors.grey,
                    ),
                    CustomTextFormField(
                      controller: adressFieldController,
                      fieldName: customerAdress,
                      hintText: adressHintText,
                      borderColor: AppColors.grey,
                    ),
                    CustomTextFormField(
                      controller: emailFieldController,
                      keyboardType: TextInputType.emailAddress,
                      fieldName: customerEmail,
                      hintText: emailHintText,
                      borderColor: AppColors.grey,
                    ),
                    CustomTextFormField(
                      controller: phoneNumberFieldController,
                      keyboardType: TextInputType.phone,
                      fieldName: customerPhoneNumber,
                      hintText: phoneNumberHintText,
                      borderColor: AppColors.grey,
                    ),
                  ],
                ),
              ),
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
                      style: AppTextStyles.medium14.apply(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

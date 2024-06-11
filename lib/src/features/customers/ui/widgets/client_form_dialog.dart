import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_colors.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

class ClientFormDialog extends StatelessWidget {
  final String title;
  final String clientName;
  final String nameHintText;
  final TextEditingController clientNameFieldController;
  final String cnpj;
  final String cnpjHintText;
  final TextEditingController cnpjFieldController;
  final String clientAdress;
  final String adressHintText;
  final TextEditingController adressFieldController;
  final String clientEmail;
  final String emailHintText;
  final TextEditingController emailFieldController;
  final String clientPhoneNumber;
  final String phoneNumberHintText;
  final TextEditingController phoneNumberFieldController;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback? onPrimaryButtonTapped;
  final VoidCallback? onSecondaryButtonTapped;

  const ClientFormDialog({
    super.key,
    required this.title,
    required this.clientName,
    required this.nameHintText,
    required this.clientNameFieldController,
    required this.cnpj,
    required this.cnpjHintText,
    required this.cnpjFieldController,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.clientAdress,
    required this.adressHintText,
    required this.adressFieldController,
    required this.phoneNumberHintText,
    required this.clientEmail,
    required this.emailHintText,
    required this.emailFieldController,
    required this.clientPhoneNumber,
    required this.phoneNumberFieldController,
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
              child: Text(
                title.toUpperCase(),
                style: AppTextStyles.medium14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: clientNameFieldController,
                    fieldName: clientName,
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
                    fieldName: clientAdress,
                    hintText: adressHintText,
                    borderColor: AppColors.grey,
                  ),
                  CustomTextFormField(
                    controller: emailFieldController,
                    keyboardType: TextInputType.emailAddress,
                    fieldName: clientEmail,
                    hintText: emailHintText,
                    borderColor: AppColors.grey,
                  ),
                  CustomTextFormField(
                    controller: phoneNumberFieldController,
                    keyboardType: TextInputType.phone,
                    fieldName: clientPhoneNumber,
                    hintText: phoneNumberHintText,
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

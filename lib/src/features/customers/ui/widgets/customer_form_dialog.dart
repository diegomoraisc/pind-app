import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pind_app/src/common/utils/validator.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

Future<dynamic> customerFormDialog({
  String? customerId,
  required BuildContext context,
  required String title,
  required String customerName,
  required String nameHintText,
  required TextEditingController nameFieldController,
  required String cnpj,
  required String cnpjHintText,
  required TextEditingController cnpjFieldController,
  required String customerAdress,
  required String adressHintText,
  required TextEditingController adressFieldController,
  required String customerEmail,
  required String emailHintText,
  required TextEditingController emailFieldController,
  required String customerPhoneNumber,
  required String phoneNumberHintText,
  required TextEditingController phoneNumberFieldController,
  required String primaryButtonText,
  required String secondaryButtonText,
  required void Function(BuildContext dialogContext) onPrimaryButtonTapped,
  required void Function(BuildContext dialogContext) onSecondaryButtonTapped,
}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      final theme = Theme.of(context);
      final formKey = GlobalKey<FormState>();
      return Dialog.fullscreen(
        backgroundColor: Colors.white,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  title.toUpperCase(),
                  style: theme.textTheme.titleSmall,
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
                          borderColor: theme.colorScheme.surface,
                          keyboardType: TextInputType.name,
                          validator: Validator.validateName,
                        ),
                        CustomTextFormField(
                          controller: cnpjFieldController,
                          keyboardType: TextInputType.number,
                          fieldName: cnpj,
                          hintText: cnpjHintText,
                          borderColor: theme.colorScheme.surface,
                          validator: Validator.validateEmptyField,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                            FilteringTextInputFormatter.digitsOnly,
                            CnpjInputFormatter(),
                          ],
                        ),
                        CustomTextFormField(
                          controller: adressFieldController,
                          keyboardType: TextInputType.streetAddress,
                          fieldName: customerAdress,
                          hintText: adressHintText,
                          validator: Validator.validateEmptyField,
                          borderColor: theme.colorScheme.surface,
                        ),
                        CustomTextFormField(
                          controller: emailFieldController,
                          keyboardType: TextInputType.emailAddress,
                          fieldName: customerEmail,
                          hintText: emailHintText,
                          validator: Validator.validateEmail,
                          borderColor: theme.colorScheme.surface,
                        ),
                        CustomTextFormField(
                          controller: phoneNumberFieldController,
                          keyboardType: TextInputType.phone,
                          fieldName: customerPhoneNumber,
                          hintText: phoneNumberHintText,
                          validator: Validator.validateEmptyField,
                          borderColor: theme.colorScheme.surface,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
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
                      onPressed: () => onSecondaryButtonTapped(ctx),
                      child: Text(
                        secondaryButtonText,
                        style: theme.textTheme.titleSmall!.apply(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            onPrimaryButtonTapped(ctx);
                          }
                        },
                        child: Text(
                          primaryButtonText,
                          style: theme.textTheme.titleSmall!
                              .apply(color: Colors.white),
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
    },
  );
}

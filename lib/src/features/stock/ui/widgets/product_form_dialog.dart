import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pind_app/src/common/utils/validator.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

Future<dynamic> productFormDialog({
  String? productId,
  required BuildContext context,
  required String title,
  required String productName,
  required String productHintText,
  required String quantity,
  required String quantityHintText,
  required TextEditingController productFieldController,
  required TextEditingController quantityFieldController,
  required String primaryButtonText,
  required String secondaryButtonText,
  required void Function(BuildContext dialogContext) onPrimaryButtonTapped,
  required void Function(BuildContext dialogContext) onSecondaryButtonTapped,
}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      final formKey = GlobalKey<FormState>();
      final theme = Theme.of(ctx);
      return Dialog.fullscreen(
        backgroundColor: Colors.white,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                          controller: productFieldController,
                          fieldName: productName,
                          hintText: productHintText,
                          borderColor: theme.colorScheme.surface,
                          validator: Validator.validateName,
                        ),
                        CustomTextFormField(
                          controller: quantityFieldController,
                          fieldName: quantity,
                          hintText: quantityHintText,
                          borderColor: theme.colorScheme.surface,
                          validator: Validator.validateEmptyField,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly,
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
                          style: theme.textTheme.titleSmall!.apply(
                            color: Colors.white,
                          ),
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
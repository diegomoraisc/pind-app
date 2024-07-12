import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pind_app/src/common/utils/validator.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

class CustomerForm extends StatefulWidget {
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
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                widget.title.toUpperCase(),
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
                        controller: widget.nameFieldController,
                        fieldName: widget.customerName,
                        hintText: widget.nameHintText,
                        borderColor: theme.colorScheme.surface,
                        keyboardType: TextInputType.name,
                        validator: Validator.validateName,
                      ),
                      CustomTextFormField(
                        controller: widget.cnpjFieldController,
                        keyboardType: TextInputType.number,
                        fieldName: widget.cnpj,
                        hintText: widget.cnpjHintText,
                        borderColor: theme.colorScheme.surface,
                        validator: Validator.validateEmptyField,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18),
                          FilteringTextInputFormatter.digitsOnly,
                          CnpjInputFormatter(),
                        ],
                      ),
                      CustomTextFormField(
                        controller: widget.adressFieldController,
                        keyboardType: TextInputType.streetAddress,
                        fieldName: widget.customerAdress,
                        hintText: widget.adressHintText,
                        validator: Validator.validateEmptyField,
                        borderColor: theme.colorScheme.surface,
                      ),
                      CustomTextFormField(
                        controller: widget.emailFieldController,
                        keyboardType: TextInputType.emailAddress,
                        fieldName: widget.customerEmail,
                        hintText: widget.emailHintText,
                        validator: Validator.validateEmail,
                        borderColor: theme.colorScheme.surface,
                      ),
                      CustomTextFormField(
                        controller: widget.phoneNumberFieldController,
                        keyboardType: TextInputType.phone,
                        fieldName: widget.customerPhoneNumber,
                        hintText: widget.phoneNumberHintText,
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
                    onPressed: widget.onSecondaryButtonTapped,
                    child: Text(
                      widget.secondaryButtonText,
                      style: theme.textTheme.titleSmall!.apply(
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onPrimaryButtonTapped?.call();
                        }
                      },
                      child: Text(
                        widget.primaryButtonText,
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
  }
}

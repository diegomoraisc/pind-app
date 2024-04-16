// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String fieldName;
  final Color? fieldNameColor;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? helperText;
  final FormFieldValidator<String>? validator;
  final defaultBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );
  const CustomTextFormField({
    Key? key,
    required this.fieldName,
    required this.hintText,
    this.fieldNameColor = Colors.black,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
    this.validator,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Text(
              fieldName,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(color: fieldNameColor),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              helperText: helperText,
              helperMaxLines: 3,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.titleSmall,
              border: defaultBorder,
              enabledBorder: defaultBorder.copyWith(
                borderSide: const BorderSide(color: Color(0xFFEDEDED)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

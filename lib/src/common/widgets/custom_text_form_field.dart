// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String fieldName;
  final Color? fieldNameColor;
  final Color? borderColor;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? helperText;
  final TextStyle? helperStyle;
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
    this.borderColor,
    this.helperStyle,
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
              style: AppTextStyles.medium14.apply(color: fieldNameColor),
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
              helperStyle: helperStyle,
              helperMaxLines: 3,
              hintText: hintText,
              hintStyle: AppTextStyles.medium14,
              border: defaultBorder,
              enabledBorder: defaultBorder.copyWith(
                borderSide: BorderSide(
                  color: borderColor ?? const Color(0xFFEDEDED),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

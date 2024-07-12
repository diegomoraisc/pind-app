import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final List<TextInputFormatter>? inputFormatters;
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
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              style: theme.textTheme.titleSmall!.apply(color: fieldNameColor),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              helperText: helperText,
              helperStyle: helperStyle,
              helperMaxLines: 3,
              hintText: hintText,
              hintStyle: theme.textTheme.titleSmall,
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

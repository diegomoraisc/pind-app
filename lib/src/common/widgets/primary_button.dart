import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  const PrimaryButton({
    Key? key,
    required this.textColor,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
    required this.fontSize,
    this.width = 143,
    this.height = 46,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          side: BorderSide(
            color: backgroundColor == Colors.transparent
                ? textColor
                : backgroundColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

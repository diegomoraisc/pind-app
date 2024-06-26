import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class CustomInlineTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final String textButton;
  final VoidCallback onPressed;
  const CustomInlineTextButton({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                text,
                style: AppTextStyles.medium14,
              ),
            ),
            Text(
              textButton,
              style: AppTextStyles.medium14.apply(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

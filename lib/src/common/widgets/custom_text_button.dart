import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.medium14.apply(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

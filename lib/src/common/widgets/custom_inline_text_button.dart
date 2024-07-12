import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
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
                style: theme.textTheme.titleSmall,
              ),
            ),
            Text(
              textButton,
              style: theme.textTheme.titleSmall!.apply(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

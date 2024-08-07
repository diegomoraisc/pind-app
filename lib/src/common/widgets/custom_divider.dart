import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  const CustomDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: Color(0xFF878787),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: Divider(
              color: theme.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}

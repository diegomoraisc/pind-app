import 'package:flutter/material.dart';
import 'package:pind_app/constants/app_colors.dart';

import '../constants/app_text_styles.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  const CustomDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
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
              style: AppTextStyles.medium14,
            ),
          ),
          const Expanded(
            child: Divider(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

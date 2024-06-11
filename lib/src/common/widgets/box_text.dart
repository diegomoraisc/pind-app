import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class BoxText extends StatelessWidget {
  final String text;
  const BoxText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: AppTextStyles.medium14,
            ),
          ),
        ),
      ),
    );
  }
}

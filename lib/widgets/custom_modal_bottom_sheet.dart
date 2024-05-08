import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/constants/app_text_styles.dart';
import 'package:pind_app/widgets/primary_button.dart';

Future<dynamic> customModalBottomSheet({
  required BuildContext context,
  required String text,
  required String bottomText,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        height: 220,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(38),
            topRight: Radius.circular(38),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                text,
                style: AppTextStyles.medium14,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              child: PrimaryButton(
                textColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                text: bottomText,
                onPressed: () => context.pop(),
                fontSize: 14,
                width: double.infinity,
                height: 52,
              ),
            ),
          ],
        ),
      );
    },
  );
}

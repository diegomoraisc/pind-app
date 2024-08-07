import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/widgets/primary_button.dart';

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
                style: Theme.of(context).textTheme.titleSmall,
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

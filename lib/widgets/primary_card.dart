import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onPressed;
  const PrimaryCard({
    super.key,
    required this.title,
    required this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 48,
            cornerSmoothing: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  bottom: 16,
                  left: 30,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .apply(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 30,
                ),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.apply(
                        color: Colors.white.withOpacity(0.8),
                      ),
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_rounded),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

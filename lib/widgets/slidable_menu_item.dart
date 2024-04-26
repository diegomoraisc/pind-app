import 'package:flutter/material.dart';

class SlidableMenuItem extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color color;
  final Color iconColor;
  const SlidableMenuItem({
    super.key,
    this.onPressed,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 25,
              color: iconColor,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Easing.emphasizedAccelerate,
              height: 5,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

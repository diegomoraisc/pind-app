import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  const CircularIconButton({
    super.key,
    this.onPressed,
    this.icon = Icons.add,
    this.iconColor = Colors.white,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      style: IconButton.styleFrom(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.secondary,
        fixedSize: const Size(60, 60),
        elevation: 2,
        shadowColor: Colors.black,
        iconSize: 30,
      ),
    );
  }
}

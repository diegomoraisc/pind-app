import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  const CustomProgressIndicator({
    Key? key,
    required this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
    );
  }
}

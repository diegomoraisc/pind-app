import 'package:flutter/material.dart';

class SlidableMenu extends StatelessWidget {
  final List<Widget> children;
  const SlidableMenu({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        children: children,
      ),
    );
  }
}

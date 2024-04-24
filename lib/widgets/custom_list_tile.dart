import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback? onPressed;
  const CustomListTile({
    super.key,
    this.onPressed,
    required this.title,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: ListTile(
        leading: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5FF),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Icon(
            leadingIcon,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .apply(color: Colors.black),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 30,
        ),
        onTap: () {},
      ),
    );
  }
}

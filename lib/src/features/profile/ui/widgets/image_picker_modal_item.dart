import 'package:flutter/material.dart';

class ImagePickerModalItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  const ImagePickerModalItem({
    super.key,
    this.onPressed,
    this.iconColor,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onPressed,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE7E7E7),
        child: Icon(
          icon,
          color: iconColor ?? theme.colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.apply(
          color: Colors.black,
        ),
      ),
    );
  }
}

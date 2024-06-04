import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

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
    return ListTile(
      onTap: onPressed,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE7E7E7),
        child: Icon(
          icon,
          color: iconColor ?? Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.medium14.apply(color: Colors.black),
      ),
    );
  }
}

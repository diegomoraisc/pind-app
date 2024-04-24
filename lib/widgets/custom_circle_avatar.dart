// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final VoidCallback? onPressed;
  final ImageProvider<Object>? backgroundImage;
  const CustomCircleAvatar({
    Key? key,
    this.onPressed,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: backgroundImage,
          backgroundColor: Colors.grey[300],
          radius: 40,
          child: backgroundImage == null
              ? const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xFFEBEBEB),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.camera_alt_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

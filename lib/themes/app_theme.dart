import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3C7B2F),
        primary: const Color(0xFF3C7B2F),
        background: const Color(0xFF78B966),
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          fontSize: 58,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

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
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: Color(0xFF878787),
        ),
      ),
    );
  }
}

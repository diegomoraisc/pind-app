import 'package:flutter/material.dart';
import 'package:pind_app/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        toolbarHeight: 100,
        elevation: 5,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black12,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.primary,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Colors.grey,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 15,
        type: BottomNavigationBarType.fixed,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        background: AppColors.background,
        brightness: Brightness.light,
      ),
    );
  }
}

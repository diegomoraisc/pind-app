import 'package:flutter/material.dart';
part 'color_scheme.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: Colors.black,
        ),
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: _lightColorScheme.surface,
        ),
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: 100,
        elevation: 5,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black12,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: _lightColorScheme.primary,
        ),
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: _lightColorScheme.surface,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 15,
        type: BottomNavigationBarType.fixed,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        iconColor: _lightColorScheme.primary,
        collapsedIconColor: _lightColorScheme.primary,
      ),
    );

import 'package:flutter/material.dart';
import 'package:pind_app/routes.dart';
import 'package:pind_app/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Pind App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      routerConfig: routeConfig,
    );
  }
}

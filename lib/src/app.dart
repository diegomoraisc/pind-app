import 'package:flutter/material.dart';
import 'package:pind_app/src/app_routes.dart';
import 'package:pind_app/src/common/constants/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Pind App",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: routeConfig,
    );
  }
}

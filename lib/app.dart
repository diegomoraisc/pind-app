import 'package:flutter/material.dart';
import 'package:pind_app/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pind App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3C7B2F),
          primary: const Color(0xFF3C7B2F),
          background: const Color(0xFF78B966),
          brightness: Brightness.light,
        ),
      ),
      home: const SplashPage(),
    );
  }
}

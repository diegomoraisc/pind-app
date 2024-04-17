import 'package:flutter/material.dart';
import 'package:pind_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pind_app/locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MyApp());
}

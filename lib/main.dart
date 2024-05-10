import 'package:flutter/material.dart';
import 'package:pind_app/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MyApp());
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/services/secure_storage.dart';

class ProfileController extends ChangeNotifier {
  final AuthService _authInstance;
  final SecureStorage _secureStorage;

  ProfileController(
    this._authInstance,
    this._secureStorage,
  );

  Future<void> signOut() async {
    try {
      await _authInstance.signOut();
      await _secureStorage.deleteAll();
      notifyListeners();
    } catch (e) {
      log('Erro ao fazer logout: $e');
    }
  }
}

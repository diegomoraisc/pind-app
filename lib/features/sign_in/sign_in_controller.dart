import 'package:flutter/material.dart';
import 'package:pind_app/features/sign_in/sign_in_state.dart';
import 'package:pind_app/services/auth_service.dart';
import 'package:pind_app/services/secure_storage.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  SignInController(
    this._authService,
    this._secureStorage,
  );

  SignInState _state = SignInInitialState();
  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _changeState(SignInLoadingState());
    try {
      final user = await _authService.signIn(
        email: email,
        password: password,
      );
      if (user.id != null) {
        await _secureStorage.write(
          key: 'CURRENT_USER',
          value: user.toJson(),
        );
        _changeState(SignInSucessState());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(SignInErrorState(e.toString()));
    }
  }
}

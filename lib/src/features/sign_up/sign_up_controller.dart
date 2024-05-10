/*import 'package:flutter/material.dart';
import 'package:pind_app/src/features/sign_up/sign_up_state.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/services/secure_storage.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  SignUpController(
    this._authService,
    this._secureStorage,
  );

  SignUpState _state = SignUpInitialState();
  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _changeState(SignUpLoadingState());
    try {
      final user = await _authService.signUp(
        name: name,
        email: email,
        password: password,
      );
      if (user.id != null) {
        await _secureStorage.write(
          key: 'CURRENT_USER',
          value: user.toJson(),
        );
        _changeState(SignUpSucessState());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(SignUpErrorState(e.toString()));
    }
  }
} */

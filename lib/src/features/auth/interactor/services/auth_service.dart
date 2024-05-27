import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';

abstract class AuthService {
  Future<AuthState> login({
    required email,
    required password,
  });

  Future<AuthState> register({
    String? name,
    required email,
    required password,
  });

  AuthState getUser();

  Future<AuthState> logout();
}

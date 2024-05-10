import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';

abstract class AuthService {
  Future<AuthState> signIn({
    required email,
    required password,
  });

  Future<AuthState> signUp({
    String? name,
    required email,
    required password,
  });

  Future<AuthState> signOut();
}

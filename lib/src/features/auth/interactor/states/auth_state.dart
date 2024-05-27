import 'package:pind_app/src/features/auth/interactor/entities/user_entity.dart';

sealed class AuthState {
  const AuthState();
}

class LoggedAuthState implements AuthState {
  final UserEntity user;

  const LoggedAuthState(this.user);
}

class RegisteredAuthState implements AuthState {
  final UserEntity user;

  const RegisteredAuthState(this.user);
}

class LoadingAuthState implements AuthState {
  const LoadingAuthState();
}

class ErrorAuthState implements AuthState {
  final String errorMessage;

  const ErrorAuthState(this.errorMessage);
}

class LoggedOutAuthState implements AuthState {
  const LoggedOutAuthState();
}

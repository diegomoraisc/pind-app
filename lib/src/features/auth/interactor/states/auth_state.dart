import 'package:pind_app/src/features/auth/interactor/entities/user_entity.dart';

sealed class AuthState {
  const AuthState();
}

class SignedInAuthState implements AuthState {
  final UserEntity user;

  const SignedInAuthState(this.user);
}

class SignedOutAuthState implements AuthState {
  const SignedOutAuthState();
}

class SignedUpAuthState implements AuthState {
  final UserEntity user;

  const SignedUpAuthState(this.user);
}

class LoadingAuthState implements AuthState {
  const LoadingAuthState();
}

class ErrorAuthState implements AuthState {
  final String message;

  const ErrorAuthState(this.message);
}

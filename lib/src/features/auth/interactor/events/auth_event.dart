sealed class AuthEvent {}

class LoginAuthEvent implements AuthEvent {
  final String email;
  final String password;

  LoginAuthEvent({
    required this.email,
    required this.password,
  });
}

class RegisterAuthEvent implements AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterAuthEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class CheckAuthEvent implements AuthEvent {}

class LogoutAuthEvent implements AuthEvent {}

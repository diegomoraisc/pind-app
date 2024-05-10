sealed class AuthEvent {}

class SignInAuthEvent implements AuthEvent {
  final String email;
  final String password;

  SignInAuthEvent({
    required this.email,
    required this.password,
  });
}

class SignUpAuthEvent implements AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpAuthEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignOutAuthEvent implements AuthEvent {}

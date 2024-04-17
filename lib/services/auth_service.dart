import 'package:pind_app/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signIn({
    required email,
    required password,
  });

  Future<UserModel> signUp({
    String? name,
    required email,
    required password,
  });

  Future<void> signOut();
}

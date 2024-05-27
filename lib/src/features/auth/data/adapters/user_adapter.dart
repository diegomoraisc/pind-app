import 'package:firebase_auth/firebase_auth.dart';
import 'package:pind_app/src/features/auth/interactor/entities/user_entity.dart';

class UserAdapter {
  static UserEntity fromFirebaseUser(User user) {
    return UserEntity(
      id: user.uid,
      name: user.displayName,
      email: user.email,
    );
  }
}

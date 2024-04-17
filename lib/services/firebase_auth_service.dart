import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pind_app/models/user_model.dart';
import 'package:pind_app/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _authInstance = FirebaseAuth.instance;

  @override
  Future<UserModel> signIn({
    required email,
    required password,
  }) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(
        id: _authInstance.currentUser!.uid,
        name: _authInstance.currentUser!.displayName,
        email: _authInstance.currentUser!.email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('Nenhum usuário encontrado com esse e-mail.');
      } else if (e.code == 'wrong-password') {
        log('Senha incorreta para esse usuário.');
      }

      throw e.message ?? "Algo está errado. Tente novamente.";
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required email,
    required password,
  }) async {
    try {
      final credential = await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      return UserModel(
        id: _authInstance.currentUser!.uid,
        name: _authInstance.currentUser!.displayName,
        email: _authInstance.currentUser!.email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        log('Já existe uma conta cadastrada com esse e-mail.');
      }

      throw e.message ?? "Algo está errado. Tente novamente.";
    }
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }
}

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pind_app/src/features/auth/data/adapters/user_adapter.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';

class FirebaseAuthService implements AuthService {
  final _firebaseAuthInstance = FirebaseAuth.instance;

  @override
  Future<AuthState> signIn({
    required email,
    required password,
  }) async {
    try {
      final result = await _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        final user = UserAdapter.fromFirebaseUser(result.user!);
        return SignedInAuthState(user);
      } else {
        return const SignedOutAuthState();
      }
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
  Future<AuthState> signUp({
    String? name,
    required email,
    required password,
  }) async {
    try {
      final result = await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user!.updateDisplayName(name);
      if (result.user != null) {
        final user = UserAdapter.fromFirebaseUser(result.user!);
        return SignedUpAuthState(user);
      } else {
        return const SignedOutAuthState();
      }
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
  Future<AuthState> signOut() async {
    await _firebaseAuthInstance.signOut();
    return const SignedOutAuthState();
  }
}

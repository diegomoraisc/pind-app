import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pind_app/src/features/auth/data/adapters/user_adapter.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';

class FirebaseAuthService implements AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthState> login({
    required email,
    required password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        final user = UserAdapter.fromFirebaseUser(result.user!);
        return LoggedAuthState(user);
      } else {
        return const LoggedOutAuthState();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('Nenhum usuário encontrado com esse e-mail.');
      } else if (e.code == 'wrong-password') {
        log('Senha incorreta para esse usuário.');
      }

      throw e.message ?? "Algo está errado. Tente novamente.";
    } catch (e) {
      return const LoggedOutAuthState();
    }
  }

  @override
  Future<AuthState> register({
    String? name,
    required email,
    required password,
  }) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user!.updateDisplayName(name);
      if (result.user != null) {
        final user = UserAdapter.fromFirebaseUser(result.user!);
        return RegisteredAuthState(user);
      } else {
        return const LoggedOutAuthState();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        log('Já existe uma conta cadastrada com esse e-mail.');
      }

      throw e.message ?? "Algo está errado. Tente novamente.";
    } catch (e) {
      return const LoggedOutAuthState();
    }
  }

  @override
  Future<AuthState> logout() async {
    await firebaseAuth.signOut();
    return const LoggedOutAuthState();
  }

  @override
  AuthState getUser() {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final userEntity = UserAdapter.fromFirebaseUser(user);
      return LoggedAuthState(userEntity);
    }
    return const LoggedOutAuthState();
  }
}

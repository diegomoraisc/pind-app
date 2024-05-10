import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/auth/interactor/events/auth_event.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;

  AuthBloc(this.service) : super(const SignedOutAuthState()) {
    on<SignInAuthEvent>(_signInAuthEvent);
    on<SignUpAuthEvent>(_signUpAuthEvent);
    on<SignOutAuthEvent>(_signOutAuthEvent);
  }

  void _signInAuthEvent(SignInAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await service.signIn(
      email: event.email,
      password: event.password,
    );
    emit(newState);
  }

  void _signUpAuthEvent(SignUpAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await service.signUp(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    emit(newState);
  }

  void _signOutAuthEvent(SignOutAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    await service.signOut();
    emit(const SignedOutAuthState());
  }
}

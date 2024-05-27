import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/auth/interactor/events/auth_event.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;

  AuthBloc(this.service) : super(const LoggedOutAuthState()) {
    on<LoginAuthEvent>(_loginAuthEvent);
    on<RegisterAuthEvent>(_registerAuthEvent);
    on<LogoutAuthEvent>(_logoutAuthEvent);
    on<CheckAuthEvent>(_checkAuthEvent);
  }

  void _loginAuthEvent(LoginAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    try {
      final newState = await service.login(
        email: event.email,
        password: event.password,
      );
      emit(newState);
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _registerAuthEvent(RegisterAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    try {
      final newState = await service.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(newState);
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _logoutAuthEvent(LogoutAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    await service.logout();
    emit(const LoggedOutAuthState());
  }

  void _checkAuthEvent(CheckAuthEvent event, emit) async {
    await Future.delayed(const Duration(seconds: 3));
    final newState = service.getUser();
    emit(newState);
  }
}

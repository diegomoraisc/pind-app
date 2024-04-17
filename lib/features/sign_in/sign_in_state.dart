abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSucessState extends SignInState {}

class SignInErrorState extends SignInState {
  final String message;

  SignInErrorState(this.message);
}

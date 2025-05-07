abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final String route;

  LoginSuccess({required this.message, required this.route});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

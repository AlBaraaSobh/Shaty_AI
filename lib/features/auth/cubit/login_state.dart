class LoginState {
  final bool isLoading;
  final String? failureMessage ;
  final String? successMessage ;
  final String? route;

  LoginState({this.isLoading = false, this.failureMessage , this.successMessage , this.route});

  factory LoginState.initial() => LoginState();

  LoginState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    String? route,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage : failureMessage ,
      successMessage : successMessage  ,
      route: route ?? this.route,
    );
  }
}
// abstract class LoginState {}
//
// class LoginInitial extends LoginState {}
//
// class LoginLoading extends LoginState {}
//
// class LoginSuccess extends LoginState {
//   final String message;
//   final String route;
//
//   LoginSuccess({required this.message, required this.route});
// }
//
// class LoginFailure extends LoginState {
//   final String error;
//
//   LoginFailure(this.error);
// }

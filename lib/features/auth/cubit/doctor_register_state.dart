
class DoctorRegisterState {
  final bool isLoading;
  final String? failureMessage ;
  final String? successMessage ;
  final String? route;

  DoctorRegisterState({this.isLoading = false, this.failureMessage , this.successMessage , this.route});

  factory DoctorRegisterState.initial() => DoctorRegisterState();

  DoctorRegisterState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    String? route,
  }) {
    return DoctorRegisterState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage : failureMessage ,
      successMessage : successMessage  ,
      route: route ?? this.route,
    );
  }
}
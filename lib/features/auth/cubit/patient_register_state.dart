
class PatientRegisterState {
  final bool isLoading;
  final String? failureMessage ;
  final String? successMessage ;
  final String? route;

  PatientRegisterState({this.isLoading = false, this.failureMessage , this.successMessage , this.route});

  factory PatientRegisterState.initial() => PatientRegisterState();

  PatientRegisterState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    String? route,
  }) {
    return PatientRegisterState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage : failureMessage ,
      successMessage : successMessage  ,
      route: route ?? this.route,
    );
  }
}
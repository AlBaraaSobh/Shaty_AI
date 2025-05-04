
abstract class PatientRegisterState {}

class PatientRegisterInitial extends PatientRegisterState {}

class PatientRegisterLoading extends PatientRegisterState {}

class PatientRegisterSuccess extends PatientRegisterState {
  final String message;
  PatientRegisterSuccess(this.message);
}

class PatientRegisterFailure extends PatientRegisterState {
  final String error;
  PatientRegisterFailure(this.error);
}

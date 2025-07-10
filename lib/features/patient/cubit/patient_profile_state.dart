class PatientProfileState {
  final bool isLoading;
  final String? successMessage;
  final String? failureMessage;

  PatientProfileState({
    this.isLoading = false,
    this.successMessage,
    this.failureMessage,
  });

  PatientProfileState copyWith({
    bool? isLoading,
    String? successMessage,
    String? failureMessage,
  }) {
    return PatientProfileState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      failureMessage: failureMessage,
    );
  }
}

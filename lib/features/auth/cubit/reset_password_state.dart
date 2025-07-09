class ResetPasswordState {
  final bool isLoading;
  final String? successMessage;
  final String? failureMessage;

  ResetPasswordState({
    this.isLoading = false,
    this.successMessage,
    this.failureMessage,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    String? successMessage,
    String? failureMessage,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      failureMessage: failureMessage,
    );
  }
}

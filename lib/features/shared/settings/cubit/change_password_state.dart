class ChangePasswordState {
  final bool isLoading;
  final String? successMessage;
  final String? failureMessage;

  ChangePasswordState({
    this.isLoading = false,
    this.successMessage,
    this.failureMessage,
  });

  factory ChangePasswordState.initial() => ChangePasswordState();

  ChangePasswordState copyWith({
    bool? isLoading,
    String? successMessage,
    String? failureMessage,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      failureMessage: failureMessage,
    );
  }
}
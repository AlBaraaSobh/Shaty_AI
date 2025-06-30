class EditProfileState {
  final bool isLoading;
  final String? successMessage;
  final String? failureMessage;

  const EditProfileState({
    required this.isLoading,
    this.successMessage,
    this.failureMessage,
  });

  factory EditProfileState.initial() => const EditProfileState(isLoading: false);

  EditProfileState copyWith({
    bool? isLoading,
    String? successMessage,
    String? failureMessage,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      failureMessage: failureMessage,
    );
  }
}
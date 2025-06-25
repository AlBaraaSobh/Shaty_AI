class IsSavedState {
  final bool isLoading;
  final bool isSaved;
  final String? errorMessage;

  IsSavedState({
    this.isLoading = false,
    this.isSaved = false,
    this.errorMessage,
  });

  IsSavedState copyWith({
    bool? isLoading,
    bool? isSaved,
    String? errorMessage,
  }) {
    return IsSavedState(
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      errorMessage: errorMessage,
    );
  }
}
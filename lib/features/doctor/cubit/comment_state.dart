import '../data/models/comment_model.dart';

class CommentState {
  final bool isLoading;
  final List<CommentModel> comments;
  final String? failureMessage;
  final String? successMessage;

  const CommentState({
    this.isLoading = false,
    this.comments = const [],
    this.failureMessage,
    this.successMessage,
  });
  factory CommentState.initial() => const CommentState();

  CommentState copyWith({
    bool? isLoading,
    List<CommentModel>? comments,
    String? failureMessage,
    String? successMessage,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comments: comments ?? this.comments,
      failureMessage: failureMessage,
      successMessage: successMessage,
    );
  }
}
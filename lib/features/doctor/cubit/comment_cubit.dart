import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/comment_state.dart';
import 'package:shaty/features/doctor/data/repositories/comment_repository.dart';

class CommentCubit extends Cubit <CommentState> {
  final CommentRepository commentRepository;
  CommentCubit(this.commentRepository) : super(CommentState.initial());

  Future<void> fetchComments(String articleId) async {
    emit(state.copyWith(isLoading: true, failureMessage: null, successMessage: null));

    try {
      final comments = await commentRepository.fetchComments(articleId);
      emit(state.copyWith(isLoading: false, comments: comments));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
    }
  }

  Future<void> addComment(String articleId, String commentText) async {
    emit(state.copyWith(isLoading: true, failureMessage: null, successMessage: null));

    try {
      await commentRepository.addComment(articleId: articleId , commentText: commentText);
      await fetchComments(articleId);
      emit(state.copyWith(successMessage: 'تم إضافة التعليق بنجاح'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
    }
  }

  Future<void> deleteComment(String commentId, String articleId) async {
    emit(state.copyWith(isLoading: true, failureMessage: null, successMessage: null));

    try {
      await commentRepository.deleteComment(commentId);
      await fetchComments(articleId);
      emit(state.copyWith(successMessage: 'تم حذف التعليق'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }

}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/saved_repository.dart';
import 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  final SavedRepository repository;

  SavedCubit(this.repository) : super(SavedState.initial());

  Future<void> getSavedArticles({bool isFirstLoad = false}) async {
    if (isFirstLoad) {
      emit(state.copyWith(isLoading: true, failureMessage: null));
    } else {
      if (!state.hasMore || state.isLoadingMore) return;
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      final response = await repository.getSavedArticles(page: state.currentPage);
      final newArticles = response.data;

      final updatedArticles = isFirstLoad
          ? newArticles
          : [...state.articles, ...newArticles];

      final bool hasMore = response.currentPage < response.lastPage;

      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        articles: updatedArticles,
        currentPage: state.currentPage + 1,
        hasMore: hasMore,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        failureMessage: e.toString(),
      ));
    }
  }

  void reset() {
    emit(SavedState.initial());
  }
}

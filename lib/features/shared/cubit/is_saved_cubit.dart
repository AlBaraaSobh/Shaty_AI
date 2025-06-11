import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/shared/cubit/is_saved_state.dart';

import '../screen/is_saved_repository.dart';

class IsSavedCubit extends Cubit<IsSavedState>{
  final IsSavedRepository repository ;
  IsSavedCubit(this.repository) : super(IsSavedState());


  Future<void> toggleSaveArticle(int articleId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final isSaved = await repository.toggleSaveArticle(articleId);
      emit(state.copyWith(isLoading: false, isSaved: isSaved));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isSaved: state.isSaved, // تبقى نفس الحالة السابقة
      ));
    }
  }
  void setInitialSaved(bool saved) {
    emit(state.copyWith(isSaved: saved));
  }
}

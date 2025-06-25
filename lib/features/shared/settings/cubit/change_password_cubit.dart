
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/shared/settings/data/repositories/change_password_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/server_exception.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepository repository;

  ChangePasswordCubit(this.repository) : super(ChangePasswordState.initial());

  Future<void> changePassword({
    required String lastPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(
        isLoading: true, successMessage: null, failureMessage: null));
    try {
      final message = await repository.changePassword(
        lastPassword: lastPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(state.copyWith(isLoading: false, successMessage: message));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: 'حدث خطأ غير متوقع'));
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }
  void clear(){
   emit(ChangePasswordState.initial());
  }
}
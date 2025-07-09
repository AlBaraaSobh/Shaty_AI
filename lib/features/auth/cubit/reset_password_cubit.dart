import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/reset_password_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepository repository;

  ResetPasswordCubit(this.repository) : super(ResetPasswordState());

  Future<void> sendEmailToReset(String email) async {
    emit(state.copyWith(isLoading: true));
    try {
      await repository.sendResetCode(email);
      emit(state.copyWith(isLoading: false, successMessage: "تم إرسال الرمز"));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
    }
  }

  Future<String> verifyCode({required String email, required String code}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final token = await repository.checkResetCode(email: email, code: code);
      emit(state.copyWith(isLoading: false));
      return token;
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String token,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await repository.resetPassword(
        email: email,
        newPassword: newPassword,
        token: token,
      );
      emit(state.copyWith(isLoading: false, successMessage: "تم التغيير بنجاح"));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
    }
  }
}

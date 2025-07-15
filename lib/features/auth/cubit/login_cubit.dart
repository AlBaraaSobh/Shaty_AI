import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/enums/user_role_enum.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/features/auth/cubit/login_state.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/network/api_consumer.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../core/utils/helpers/storage_helper.dart';
import '../data/repositories/login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;

  LoginCubit(this.repository) : super(LoginState.initial());

  Future<void> loginCubit({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      final response = await repository.login(email: email, password: password);
      final user = response['user'];

      final bool isDoctorFromAPI =
          user.containsKey('bio') && user.containsKey('jop_specialty_number');
      final bool isPatientFromAPI = !isDoctorFromAPI;

      if ((role == UserRole.doctor && isPatientFromAPI) ||
          (role == UserRole.patient && isDoctorFromAPI)) {
        emit(state.copyWith(
            isLoading: false,
            failureMessage: 'الرجاء التأكد من اختيار نوع المستخدم الصحيح'));
        return;
      }

      final route = role == UserRole.doctor
          ? '/bottom_navigation_screen'
          : '/patient_bottom_nav_bar';

      await StorageHelper.saveToken(response['token']);
      await StorageHelper.saveUserType(
          role == UserRole.doctor ? 'doctor' : 'patient');
      // await StorageHelper.saveUserId(user.id);
      await StorageHelper.saveData('name', user['name']);
      print('Saved name: ${user['name']}');

      await StorageHelper.saveData('email', user['email']);
      print('Saved email: ${user['email']}');

      await StorageHelper.saveData('img', user['img'] ?? '');
      print('Saved img: ${user['img'] ?? ''}');

      await StorageHelper.saveUserId(user['id']);

      emit(state.copyWith(
          isLoading: false,
          successMessage: "تم تسجيل الدخول بنجاح",
          route: route));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      if (message.contains('credentials')) {
        emit(state.copyWith(
            isLoading: false, failureMessage: 'بيانات الدخول غير صحيحة'));
      } else {
        emit(state.copyWith(isLoading: false, failureMessage: message));
      }
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }

  void clear() {
    emit(LoginState.initial());
  }
// Future<void> loginCubit({
//   required String email,
//   required String password,
//   required UserRole role,
//
// }) async {
//   emit(state.copyWith(
//       isLoading: true, failureMessage: null, successMessage: null));
//   try {
//     final response = await api.post(EndPoints.login,
//     data: {
//       "email": email.trim(),
//       "password": password.trim(),
//     }
//     );
//     final user = response['user'];
//
//     final bool isDoctorFromAPI = user.containsKey('bio') && user.containsKey('jop_specialty_number');
//     final bool isPatientFromAPI = !isDoctorFromAPI;
//
//     if ((role == UserRole.doctor && isPatientFromAPI) ||
//         (role == UserRole.patient && isDoctorFromAPI)) {
//       emit(state.copyWith(isLoading : false ,failureMessage: 'الرجاء التأكد من اختيار نوع المستخدم الصحيح'));
//       return;
//     }
//
//     // تحديد المسار المناسب حسب الدور
//     final route = role == UserRole.doctor
//         ? '/bottom_navigation_screen'
//         : '/patient_bottom_nav_bar';
//
//     await StorageHelper.saveToken(response['token']);
//     await StorageHelper.saveUserType(role == UserRole.doctor ? 'doctor' : 'patient');
//     await StorageHelper.saveUserId(user.id);
//     emit(state.copyWith(isLoading : false,successMessage: "تم تسجيل الدخول بنجاح" ,route: route));
//
//   }  catch (e) {
//     final message = ErrorHandler.handle(e);
//     if (message.contains('credentials')) {
//       Helpers.showToast(message: 'بيانات الدخول غير صحيحة');
//       emit(state.copyWith(isLoading: false,failureMessage: 'بيانات الدخول غير صحيحة'));
//     } else {
//       Helpers.showToast(message: message);
//       emit(state.copyWith(isLoading : false ,failureMessage: message));
//     }
//
//   }
// }
// void clearMessages() {
//   emit(state.copyWith(successMessage: null, failureMessage: null));
// }
}

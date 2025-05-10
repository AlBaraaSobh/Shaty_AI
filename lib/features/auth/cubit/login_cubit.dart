import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/enums/user_role_enum.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/features/auth/cubit/login_state.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/network/api_consumer.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../core/utils/helpers/storage_helper.dart';


class LoginCubit extends Cubit<LoginState> {
  final ApiConsumer api;
  LoginCubit(this.api) : super(LoginInitial());

  Future<void> loginCubit({
    required String email,
    required String password,
    required UserRole role,

  }) async {
    emit(LoginLoading());
    try {
      final response = await api.post(EndPoints.baseUrl + EndPoints.login,
      data: {
        "email": email.trim(),
        "password": password.trim(),
      }
      );
      final user = response['user'];

      final bool isDoctorFromAPI = user.containsKey('bio') && user.containsKey('jop_specialty_number');
      final bool isPatientFromAPI = !isDoctorFromAPI;

      if ((role == UserRole.doctor && isPatientFromAPI) ||
          (role == UserRole.patient && isDoctorFromAPI)) {
        emit(LoginFailure("الرجاء التأكد من اختيار نوع المستخدم الصحيح."));
        return;
      }

      // تحديد المسار المناسب حسب الدور
      final route = role == UserRole.doctor
          ? '/bottom_navigation_screen'
          : '/patient_bottom_nav_bar';

      await StorageHelper.saveToken(response['token']);
      await StorageHelper.saveUserType(role == UserRole.doctor ? 'doctor' : 'patient');
      emit(LoginSuccess(message: "تم تسجيل الدخول بنجاح", route: route));

    }  catch (e) {
      final message = ErrorHandler.handle(e);
      if (message.contains('credentials')) {
        Helpers.showToast(message: 'بيانات الدخول غير صحيحة');
        emit(LoginFailure('بيانات الدخول غير صحيحة'));
      } else {
        Helpers.showToast(message: message);
        emit(LoginFailure(message));
      }

    }
  }
}

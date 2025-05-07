import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/features/auth/cubit/doctor_register_state.dart';
import 'package:shaty/features/auth/models/doctor_model.dart';
import 'package:shaty/features/auth/models/doctor_register_model.dart';
import 'package:shaty/features/auth/models/doctor_response_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helpers/helpers.dart';

class DoctorRegisterCubit extends Cubit<DoctorRegisterState> {
  final ApiConsumer api;

  DoctorRegisterCubit(this.api) : super(DoctorRegisterInitial());

  Future<void> registerDoctorCubit(DoctorRegisterModel doctor) async {
    emit(DoctorRegisterLoading());
    try {
      final response = await api.post(EndPoints.baseUrl + EndPoints.register,
          data: doctor.toJson());
      final authDoctor = DoctorResponseModel.fromJson(response);
      print("User ID: ${authDoctor.user.id}");
      print("Token: ${authDoctor.token}");
      emit(DoctorRegisterSuccess("تم التسجيل بنجاح"));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(DoctorRegisterFailure(message));
      Helpers.showToast(message: message);

    }
  }
}

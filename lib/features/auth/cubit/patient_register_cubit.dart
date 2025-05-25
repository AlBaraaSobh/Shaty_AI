import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/features/auth/cubit/patient_register_state.dart';
import 'package:shaty/features/auth/models/patient_response_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../core/utils/helpers/storage_helper.dart';
import '../models/patient_register_model .dart';

class PatientRegisterCubit extends Cubit<PatientRegisterState> {
  PatientRegisterCubit(this.api) : super(PatientRegisterState.initial());
  final ApiConsumer api ;

 Future <void> registerPatientCubit(PatientRegisterModel patient) async {
    emit(state.copyWith(isLoading: true , successMessage: null ,failureMessage: null));
    try {
      final response = await api.post(EndPoints.register,
          data: patient.toJson(),
      );
      final authResponse = PatientResponseModel.fromJson(response);
     print("User ID: ${authResponse.user.id}");
     print("Token: ${authResponse.token}");
      await StorageHelper.saveToken(authResponse.token);
      emit(state.copyWith(isLoading: false,successMessage:"تم التسجيل بنجاح"));

      Helpers.showToast(message: "تم التسجيل بنجاح");


    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false,failureMessage:message));

      Helpers.showToast(message: message);
    }
  }
}

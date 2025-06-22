import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/features/auth/cubit/patient_register_state.dart';

import '../../../core/utils/helpers/helpers.dart';
import '../../../core/utils/helpers/storage_helper.dart';
import '../data/models/patient_register_model .dart';
import '../data/models/patient_response_model.dart';
import '../data/repositories/patient_register_repository.dart';

class PatientRegisterCubit extends Cubit<PatientRegisterState> {

  final PatientRegisterRepository repository;

  PatientRegisterCubit(this.repository) : super(PatientRegisterState.initial());

  Future<void> registerPatientCubit(PatientRegisterModel patient) async {
    emit(state.copyWith(isLoading: true, successMessage: null, failureMessage: null));
    try {
      final authResponse = await repository.registerPatient(patient);
      await StorageHelper.saveToken(authResponse.token);
      emit(state.copyWith(isLoading: false, successMessage: "تم التسجيل بنجاح"));
      Helpers.showToast(message: "تم التسجيل بنجاح");
    } catch (e) {
      final message = e.toString();
      emit(state.copyWith(isLoading: false, failureMessage: message));
      Helpers.showToast(message: message);
    }
  }

 // Future <void> registerPatientCubit(PatientRegisterModel patient) async {
 //    emit(state.copyWith(isLoading: true , successMessage: null ,failureMessage: null));
 //    try {
 //      final response = await api.post(EndPoints.register,
 //          data: patient.toJson(),
 //      );
 //      final authResponse = PatientResponseModel.fromJson(response);
 //     print("User ID: ${authResponse.user.id}");
 //     print("Token: ${authResponse.token}");
 //      await StorageHelper.saveToken(authResponse.token);
 //      emit(state.copyWith(isLoading: false,successMessage:"تم التسجيل بنجاح"));
 //
 //      Helpers.showToast(message: "تم التسجيل بنجاح");
 //
 //
 //    } catch (e) {
 //      final message = ErrorHandler.handle(e);
 //      emit(state.copyWith(isLoading: false,failureMessage:message));
 //
 //      Helpers.showToast(message: message);
 //    }
 //  }
}

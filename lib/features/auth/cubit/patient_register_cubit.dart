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
      final response = await api.post(EndPoints.baseUrl + EndPoints.register,
          data: patient.toJson(),
          // options: Options(headers: {
          //   'Accept': 'application/json',
          // })
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
// void registerPatientCubit(PatientRegisterModel patient) async {
//   emit(PatientRegisterLoading());
//   try {
//     final response = await Dio().post(
//       EndPoints.baseUrl + EndPoints.register,
//       options: Options(
//         headers: {
//           'Accept': 'application/json',
//         },
//       ),
//       data: patient.toJson(),
//
//     );
//     print("👩‍💻 the response data is  = : ${response.data}");
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final authResponse = PatientResponseModel.fromJson(response.data);
//       //TODO  حفظ التوكن أو بيانات المستخدم
//       print("User ID: ${authResponse.user.id}");
//       print("Token: ${authResponse.token}");
//       emit(PatientRegisterSuccess("Registration successful"));
//     } else {
//       emit(PatientRegisterFailure(
//           "Registration failed: ${response.statusMessage}"));
//     }
//   } catch (e) {
//     final message = ErrorHandler.handle(e);
//     emit(PatientRegisterFailure(message));
//   }
// }

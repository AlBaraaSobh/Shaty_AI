import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../data/models/doctor_register_model.dart';
import '../data/models/doctor_response_model.dart';
import '../data/repositories/doctor_register_repository.dart';
import 'doctor_register_state.dart';

class DoctorRegisterCubit extends Cubit<DoctorRegisterState> {
  final DoctorRegisterRepository repository;

  DoctorRegisterCubit(this.repository) : super(DoctorRegisterState.initial());

  Future<void> registerDoctorCubit(DoctorRegisterModel doctor) async {
    emit(state.copyWith(isLoading: true, failureMessage: null, successMessage: null));

    try {
      final authDoctor = await repository.registerDoctor(doctor);
      print("User ID: ${authDoctor.user.id}");
      print("Token: ${authDoctor.token}");
      emit(state.copyWith(isLoading: false, successMessage: "تم التسجيل بنجاح"));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// import '../../../core/errors/exceptions.dart';
// import '../../../core/network/api_consumer.dart';
// import '../../../core/network/end_points.dart';
// import '../../../core/utils/helpers/helpers.dart';
// import '../data/models/doctor_register_model.dart';
// import '../data/models/doctor_response_model.dart';
// import 'doctor_register_state.dart';
//
// class DoctorRegisterCubit extends Cubit<DoctorRegisterState> {
//   final ApiConsumer api;
//
//   DoctorRegisterCubit(this.api) : super(DoctorRegisterState.initial());
//
//   Future<void> registerDoctorCubit(DoctorRegisterModel doctor) async {
//     emit(state.copyWith(isLoading:  true,failureMessage: null, successMessage: null));
//     try {
//       final response = await api.post(EndPoints.register,
//           data: doctor.toJson());
//       final authDoctor = DoctorResponseModel.fromJson(response);
//       print("User ID: ${authDoctor.user.id}");
//       print("Token: ${authDoctor.token}");
//       emit(state.copyWith(isLoading: false,successMessage:"تم التسجيل بنجاح"));
//     } catch (e) {
//       final message = ErrorHandler.handle(e);
//       emit(state.copyWith(isLoading: false,failureMessage:message));
//       Helpers.showToast(message: message);
//
//     }
//   }
// }

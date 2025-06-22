import 'package:shaty/core/errors/exceptions.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import '../models/doctor_register_model.dart';
import '../models/doctor_response_model.dart';

class DoctorRegisterRepository {
  final ApiConsumer api;

  DoctorRegisterRepository(this.api);

  Future<DoctorResponseModel> registerDoctor(DoctorRegisterModel doctor) async {
    try {
      final response = await api.post(
        EndPoints.register,
        data: doctor.toJson(),
      );
      return DoctorResponseModel.fromJson(response);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

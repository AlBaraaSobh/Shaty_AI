import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/features/auth/data/models/patient_register_model%20.dart';
import 'package:shaty/features/auth/data/models/patient_response_model.dart';
import '../../../../core/errors/exceptions.dart';

class PatientRegisterRepository {
  final ApiConsumer api;

  PatientRegisterRepository(this.api);

  Future<PatientResponseModel> registerPatient(PatientRegisterModel patient) async {
    try {
      final response = await api.post(EndPoints.register, data: patient.toJson());
      return PatientResponseModel.fromJson(response);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

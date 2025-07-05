import 'package:shaty/core/network/end_points.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/utils/helpers/storage_helper.dart';
import '../models/doctor_specialty_model.dart';

class PatientDoctorsRepository {
  final ApiConsumer api;

  PatientDoctorsRepository(this.api);

  /// جلب كل الأطباء الذين يتابعهم المستخدم
  Future<List<DoctorSpecialtyModel>> getDoctors() async {
    await _ensureToken();
    final response = await api.get(EndPoints.getAllDoctors);
    final List<dynamic> data = response;
    return data.map((json) => DoctorSpecialtyModel.fromJson(json)).toList();
  }

  /// جلب الأطباء حسب تخصص معين
  Future<List<DoctorSpecialtyModel>> getDoctorsBySpecialty(int specialtyId) async {
    await _ensureToken();
    final response = await api.get(EndPoints.getDoctorsBySpecialty(specialtyId));

    if (response == null || response['data'] == null) {
      throw Exception("لا يوجد بيانات");
    }

    final List<dynamic> data = response['data'];
    return data.map((json) => DoctorSpecialtyModel.fromJson(json)).toList();
  }

  /// تبديل حالة المتابعة للطبيب (تابع / إلغاء المتابعة)
  Future<bool> toggleFollowDoctor(int doctorId) async {
    await _ensureToken();
    final response = await api.post(EndPoints.followDoctor(doctorId));

    if (response is Map<String, dynamic> && response.containsKey('following')) {
      return response['following'] as bool;
    }

    throw Exception("الرد غير متوقع من الخادم");
  }

  /// تأكد من وجود التوكن وإلا ارمه Exception
  Future<void> _ensureToken() async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Authentication token is missing");
  }
}

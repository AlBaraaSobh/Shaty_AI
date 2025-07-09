import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/doctor_notification.dart';

class NotificationRepository {
  final ApiConsumer api;

  NotificationRepository(this.api);

  Future<List<DoctorNotification>> getNotifications() async {
    final response = await api.get(EndPoints.doctorNotifications);

    final List<dynamic> data = response;
    return data.map((e) => DoctorNotification.fromJson(e)).toList();
  }

  Future<List<DoctorNotification>> getPatientNotifications() async {
    final response = await api.get(EndPoints.patientNotifications);

    final List<dynamic> data = response;
    return data.map((e) => DoctorNotification.fromJson(e)).toList();
  }
}


import '../data/models/doctor_notification.dart';

class NotificationState {
  final bool isLoading;
  final String? failureMessage;
  final String? successMessage;
  final List<DoctorNotification> notifications;

  NotificationState({
    this.isLoading = false,
    this.failureMessage,
    this.successMessage,
    this.notifications = const [],
  });

  factory NotificationState.initial() => NotificationState();

  NotificationState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    List<DoctorNotification>? notifications,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage: failureMessage,
      successMessage: successMessage,
      notifications: notifications ?? this.notifications,
    );
  }
}

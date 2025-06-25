import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/data/repositories/notification_repository.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository repository;

  NotificationCubit(this.repository) : super(NotificationState.initial());

  Future<void> fetchNotifications() async {
    emit(state.copyWith(isLoading: true, failureMessage: null));

    try {
      final notifications = await repository.getNotifications();
      emit(state.copyWith(isLoading: false, notifications: notifications));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: "فشل في تحميل الإشعارات"));
    }
  }

  void clearMessages() {
    emit(state.copyWith(failureMessage: null, successMessage: null));
  }
  void clear() {
    emit(NotificationState.initial());
  }
}

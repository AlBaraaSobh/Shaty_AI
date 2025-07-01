import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/notification_cubit.dart';
import 'package:shaty/features/doctor/cubit/notification_state.dart';
import 'package:shaty/features/doctor/widget/notification_item.dart';

class DoctorNotificationsScreen extends StatefulWidget {
  const DoctorNotificationsScreen({super.key});

  @override
  State<DoctorNotificationsScreen> createState() => _DoctorNotificationsScreenState();
}
class _DoctorNotificationsScreenState extends State<DoctorNotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإشعارات',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failureMessage != null) {
            return Center(child: Text(state.failureMessage!));
          }

          if (state.notifications.isEmpty) {
            return const Center(child: Text('لا توجد إشعارات حالياً'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<NotificationCubit>().fetchNotifications();
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final item = state.notifications[index];
                return NotificationItem(
                  title: item.title,
                  subTitle: item.description,
                  time: item.createdAt,
                  type: item.type,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 0.5,
                height: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}



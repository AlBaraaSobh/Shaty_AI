import 'package:flutter/material.dart';
import 'package:shaty/features/doctor/widget/notification_item.dart';

class DoctorNotificationsScreen extends StatefulWidget {
  const DoctorNotificationsScreen({super.key});

  @override
  State<DoctorNotificationsScreen> createState() =>
      _DoctorNotificationsScreenState();
}

class _DoctorNotificationsScreenState extends State<DoctorNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'لديك متابع جديد',
        'subtitle': 'قام المستخدم البراء أشرف صبح بمتابعتك',
        'time': 'منذ 1 أيام',
      },
      {
        'title': 'لديك تعليق جديد',
        'subtitle': 'علق البراء على المقالة (أنا سعيد جدًا)',
        'time': 'منذ ساعة',
      },
      {
        'title': 'لديك إعجاب جديد',
        'subtitle': 'أعجب المستخدم البراء أشرف بمقالتك',
        'time': 'منذ20 دقيقة',
      },
      {
        'title': 'لديك متابع جديد',
        'subtitle': 'قام المستخدم البراء أشرف صبح بمتابعتك',
        'time': 'منذ 1 أيام',
      },
      {
        'title': 'لديك تعليق جديد',
        'subtitle': 'علق البراء على المقالة (أنا سعيد جدًا)',
        'time': 'منذ ساعة',
      },
      {
        'title': 'لديك إعجاب جديد',
        'subtitle': 'أعجب المستخدم البراء أشرف بمقالتك',
        'time': 'منذ20 دقيقة',
      },
    ];
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final item = notifications[index];
            return Column(
              children:[ NotificationItem(
                  title: item['title'] ?? 'عنوان غير معروف',
                  subTitle: item['subtitle'] ?? 'تفاصيل غير معروفة',
                  time: item['time'] ?? 'وقت غير معروف'),
                if (index < notifications.length - 1)
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 20, // المسافة بين العناصر
                  ),

              ]
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/notifications_active.png', width: 24, height: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
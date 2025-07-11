import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  final String type;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconData(type);
    final iconColor = _getIconColor(type);
    final backgroundColor = _getBackgroundColor(type);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // أيقونة دائرية ناعمة
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        // محتوى الإشعار
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subTitle),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ✅ أيقونات حسب نوع الإشعار
  IconData _getIconData(String type) {
    switch (type) {
      case 'NewCommentNotification':
        return Icons.comment;
      case 'NewFollowerNotifiacation':
        return Icons.person_add;
      case 'NewArticleNotifiacation':
        return Icons.article;
      default:
        return Icons.notifications;
    }
  }

  // ✅ لون الأيقونة حسب النوع
  Color _getIconColor(String type) {
    switch (type) {
      case 'NewCommentNotification':
        return Colors.blue;
      case 'NewFollowerNotifiacation':
        return AppColors.primaryColor;
      case 'NewArticleNotifiacation':
        return AppColors.primaryColor;
      default:
        return Colors.grey;
    }
  }

  // ✅ خلفية ناعمة للأيقونة
  Color _getBackgroundColor(String type) {
    switch (type) {
      case 'NewCommentNotification':
        return Colors.blue.withOpacity(0.1);
      case 'NewFollowerNotifiacation':
        return Colors.deepPurple.withOpacity(0.1);
      case 'NewArticleNotifiacation':
        return Colors.green.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }
}


// import 'package:flutter/material.dart';
//
// class NotificationItem extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final String time;
//   final String type;
//
//   const NotificationItem({
//     super.key,
//     required this.title,
//     required this.subTitle,
//     required this.time,
//     required this.type,
//   });
//
//   IconData _getIconByType(String type) {
//     switch (type) {
//       case 'NewCommentNotification':
//         return Icons.comment;
//       case 'NewLikeNotification':
//         return Icons.favorite;
//       case 'NewFollowNotification':
//         return Icons.person_add;
//       default:
//         return Icons.notifications;
//     }
//   }
//
//   Color _getColorByType(String type) {
//     switch (type) {
//       case 'NewCommentNotification':
//         return Colors.blue;
//       case 'NewLikeNotification':
//         return Colors.red;
//       case 'NewFollowNotification':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 24,
//           backgroundColor: _getColorByType(type).withOpacity(0.1),
//           child: Icon(_getIconByType(type), color: _getColorByType(type), size: 26),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 subTitle,
//                 style: TextStyle(color: Colors.grey[700], fontSize: 14),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 time,
//                 style: TextStyle(color: Colors.grey[500], fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class NotificationItem extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final String time;
//
//   const NotificationItem({
//     super.key,
//     required this.title,
//     required this.subTitle,
//     required this.time,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('images/notifications_active.png', width: 24, height: 24),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subTitle,
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               time,
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//       ],
//     );
//   }
// }
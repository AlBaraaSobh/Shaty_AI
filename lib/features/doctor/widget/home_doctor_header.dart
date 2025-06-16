import 'package:flutter/material.dart';
import 'package:shaty/core/constants/user_type.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import '../../../core/constants/app_colors.dart';
import 'create_post_bottom_sheet.dart';

class HomeDoctorHeader extends StatelessWidget {
  const HomeDoctorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('images/doctor.png'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 48,
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.loc.search,
                  prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
                  fillColor: Colors.grey.shade100,  // خلفية شريط البحث فاتحة جداً
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (UserType.isDoctor)
            Container(
              width: 50,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,  // خلفية زر الإضافة فاتحة جداً
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  _showCreatePostBottomSheet(context);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.primaryColor,
                  size: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showCreatePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const CreatePostBottomSheet(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shaty/core/constants/user_type.dart';
// import 'package:shaty/core/extensions/localization_extension.dart';
// import '../../../core/constants/app_colors.dart';
// import 'create_post_bottom_sheet.dart';
//
// class HomeDoctorHeader extends StatelessWidget {
//   const HomeDoctorHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 25,
//             backgroundImage: AssetImage('images/doctor.png'),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: SizedBox(
//               height: 48,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: context.loc.search,
//                   prefixIcon: const Icon(Icons.search_rounded),
//                   fillColor: Colors.grey.shade200,
//                   filled: true,
//                   contentPadding: EdgeInsets.zero,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (UserType.isDoctor)
//             Container(
//               width: 50,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFECECEC),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: IconButton(
//                 onPressed: () {
//                   _showCreatePostBottomSheet(context);
//                 },
//                 icon: const Icon(
//                   Icons.add_circle,
//                   color: AppColors.primaryColor,
//                   size: 32,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _showCreatePostBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => const CreatePostBottomSheet(),
//     );
//   }
// }

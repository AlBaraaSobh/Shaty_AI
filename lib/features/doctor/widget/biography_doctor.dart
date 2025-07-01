import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import '../cubit/doctor_profile_cubit.dart';
import '../cubit/doctor_profile_state.dart';
import 'edit_biography_bottom_sheet.dart';

class BiographyDoctor extends StatelessWidget {
  const BiographyDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        final bio = state.doctor?.bio?.trim();
        final biographyText =
        (bio?.isNotEmpty ?? false) ? bio! : 'لا يوجد سيرة ذاتية';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان مع زر التعديل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.loc.biography,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                IconButton(
                  tooltip: 'تعديل',
                  onPressed: () => _showEditBiographySheet(context, state.doctor?.bio),
                  icon: const Icon(
                    Icons.edit,
                    size: 22,
                    color: AppColors.primaryColor,
                  ),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white, // خلفية موحدة تتماشى مع خلفية التطبيق
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                biographyText,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: (bio?.isNotEmpty ?? false)
                      ? AppColors.secondaryColor
                      : AppColors.accentColor,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

          ],
        );
      },
    );
  }

  void _showEditBiographySheet(BuildContext context, String? initialBio) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => EditBiographyBottomSheet(initialBio: initialBio),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shaty/core/constants/app_colors.dart';
// import 'package:shaty/core/localization/localization_extension.dart';
// import '../cubit/doctor_profile_cubit.dart';
// import '../cubit/doctor_profile_state.dart';
// import 'edit_biography_bottom_sheet.dart';
//
// class BiographyDoctor extends StatelessWidget {
//   const BiographyDoctor({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
//       builder: (context, state) {
//         final biographyText = state.doctor?.bio ?? 'لا يوجد سيرة ذاتية';
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // العنوان مع زر التعديل
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   context.loc.biography,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                       ),
//                       builder: (_) => EditBiographyBottomSheet(
//                         initialBio: state.doctor?.bio,
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.edit, size: 18),
//                 ),
//
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: Text(
//                 biographyText,
//                 maxLines: 5,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: AppColors.secondaryColor,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

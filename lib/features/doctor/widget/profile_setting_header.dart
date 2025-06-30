import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../doctor/cubit/doctor_profile_cubit.dart';
import '../../doctor/cubit/doctor_profile_state.dart';

class ProfileSettingHeader extends StatelessWidget {
  const ProfileSettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        final doctor = state.doctor;

        // استخدم صورة الطبيب إذا موجودة، وإلا الصورة الافتراضية
        final ImageProvider avatarImage = (doctor?.img != null && doctor!.img!.isNotEmpty)
            ? NetworkImage(doctor.img!.replaceAll('127.0.0.1', '10.0.2.2'))
            : const AssetImage('images/doctor.png');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: avatarImage,
                ),
                Positioned(
                  bottom: 3,
                  right: 1,
                  child: InkWell(
                    onTap: () {
                      // هنا ممكن تفتح اختيار صورة الكاميرا أو المعرض
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // نفس وظيفة onTap
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              doctor?.name ?? 'لا توجد بيانات',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              doctor?.specialties.map((s) => s.name).join(', ') ?? '',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(144, 36),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/edit_doctor_profile_screen');
              },
              child: const Text(
                'تعديل الملف الشخصي',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
//
// import '../../../core/constants/app_colors.dart';
// class ProfileSettingHeader extends StatelessWidget {
//   const ProfileSettingHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('images/doctor.png'),
//             ),
//             Positioned(
//               bottom: 3,
//               right: 1,
//               child: InkWell(
//                 onTap: () {},
//                 child: SizedBox(
//                   height: 40,
//                   width: 40,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.camera_alt,
//                         size: 20,
//                         color: AppColors.primaryColor,
//                       ),
//
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Text('د. البراء أشرف صبح',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
//         Text('أخصائي الغدد الصماء',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
//         SizedBox(height: 12,),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primaryColor,
//             minimumSize: Size(144,36),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           ),
//           onPressed: () {
//             Navigator.pushNamed(context, '/edit_doctor_profile_screen');
//           },
//           child: Text(
//             'تعديل الملف الشخصي',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

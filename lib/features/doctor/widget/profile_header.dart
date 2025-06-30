import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_state.dart';
import '../../../core/constants/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  String fixImageUrl(String url) {
    if (url.contains('127.0.0.1')) {
      return url.replaceFirst('127.0.0.1', '10.0.2.2');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        final doctor = state.doctor;
        if (doctor == null) {
          return const Text("لا توجد بيانات للطبيب.");
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: doctor.img != null
                      ? NetworkImage(fixImageUrl(doctor.img!))
                      : const AssetImage('images/doctor.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 3,
                  right: 1,
                  child: InkWell(
                    onTap: () {
                      //TODO
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
                          onPressed: (){},
                          icon: Icon(
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
              doctor.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Text(
              doctor.specialties.map((s) => s.name).join(', '),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
          ],
        );
      },
    );
  }

}

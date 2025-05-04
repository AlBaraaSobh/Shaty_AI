import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
class ProfileSettingHeader extends StatelessWidget {
  const ProfileSettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/doctor.png'),
            ),
            Positioned(
              bottom: 3,
              right: 1,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {},
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
        Text('د. البراء أشرف صبح',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        Text('أخصائي الغدد الصماء',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
        SizedBox(height: 12,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: Size(144,36),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {

          },
          child: Text(
            'تعديل الملف الشخصي',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

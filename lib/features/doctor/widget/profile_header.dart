import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

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
        Text('د. البراء أشرف صبح',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        Text('أخصائي الغدد الصماء',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),

      ],
    );
  }
}

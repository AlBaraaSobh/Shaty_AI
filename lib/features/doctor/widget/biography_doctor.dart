import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

class BiographyDoctor extends StatelessWidget {
  const BiographyDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final biographyText =
        'متخصص في تشخيص وعلاج الحالات التي تؤثر على الغدد الصماء في الجسم، وهي الغدد التي تفرز الهرمونات الضرورية لتنظيم وظائف الجسم المختلفة';

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
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO: فعل التعديل هنا
              },
              icon: const Icon(Icons.edit, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // نص السيرة الذاتية داخل حاوية أنيقة
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50], // لون خلفية أفتح
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            biographyText,
            maxLines: 3,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondaryColor,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

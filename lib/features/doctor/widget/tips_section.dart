import 'package:flutter/material.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import 'package:shaty/features/doctor/widget/create_tips_bottom_sheet.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/user_type.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      'اشرب الماء بانتظام خلال اليوم.',
      'نم جيدًا لتحسين صحتك النفسية.',
      'مارس الرياضة 3 مرات أسبوعيًا.',
      // أضف المزيد من النصائح هنا إذا لزم الأمر للاختبار
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.loc.daily_tips,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              if (UserType
                  .isDoctor)
                IconButton(
                  onPressed: () {
                    _showCreateTipsBottomSheet(context);
                  },
                  icon: const Icon(Icons.add_circle,
                      color: AppColors.primaryColor),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 180, // ارتفاع ثابت لعرض النصائح
            child: ListView.separated(
              //physics: const NeverScrollableScrollPhysics(), // إذا كنت تستخدم SingleChildScrollView خارجيًا
              itemCount: tips.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final tip = tips[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    // استخدم لون border مناسب أو لا تستخدم border إذا لم تكن هناك حاجة
                    border: Border.all(
                        color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      // الحاجز الأزرق
                      Container(
                        width: 5,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(fontSize: 16),
                          // softWrap: true, // للتأكد من التفاف النص إذا كان طويلاً
                        ),
                      ),
                      if (UserType.isDoctor) ...[
                        IconButton(
                          icon: const Icon(Icons.edit,
                              size: 20, color: Colors.grey),
                          onPressed: () {
                            // TODO: إضافة منطق تعديل النصيحة
                            print('Edit tip: $tip');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              size: 20,
                              color: Colors.grey),
                          onPressed: () {
                            // TODO: إضافة منطق حذف النصيحة
                            print('Delete tip: $tip');
                          },
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // الدالة لعرض BottomSheet
  void _showCreateTipsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          const CreateTipsBottomSheet(),
    );
  }
}

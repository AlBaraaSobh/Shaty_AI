import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/user_type.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/widgets/show_alert_Dialog.dart';
import '../cubit/tips_cubit.dart';
import '../cubit/tips_state.dart';
import '../data/models/tips_model.dart';

class TipsSection extends StatefulWidget {
  const TipsSection({super.key});

  @override
  State<TipsSection> createState() => _TipsSectionState();
}

class _TipsSectionState extends State<TipsSection> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TipsCubit, TipsState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          Helpers.showToast(message: state.successMessage!);
          context.read<TipsCubit>().clearMessages();
        } else if (state.failureMessage != null) {
          Helpers.showToast(message: state.failureMessage!);
        }
      },
      builder: (context, state) {
        final tips = state.tips.toList();
        final displayedTips = tips.take(3).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // رأس القسم مع العنوان والأزرار
              Row(
                children: [
                  Text(
                    context.loc.daily_tips,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  if (tips.length > 3)
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/view_tips');
                      },
                      child: Text(
                        context.loc.view_all,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  if (UserType.isDoctor)
                    IconButton(
                      onPressed: () {
                        Helpers.showCreateTipsBottomSheet(context);
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: AppColors.primaryColor,
                        size: 28,
                      ),
                      tooltip: 'إضافة نصيحة',
                    ),
                ],
              ),

              const SizedBox(height: 14),

              // المحتوى: تحميل أو عرض النصائح
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (tips.isEmpty)
                Center(
                  child: Text(
                    "لا توجد نصائح حالياً",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedTips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final tip = displayedTips[index];
                    return _buildTipItem(tip);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTipItem(TipsModel tip) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          // الخط الأزرق العمودي
          Container(
            width: 6,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 16),

          // نص النصيحة
          Expanded(
            child: Text(
              tip.advice,
              style: const TextStyle(
                fontSize: 17,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ),

          // أزرار التعديل والحذف للطبيب فقط
          if (UserType.isDoctor) ...[
            IconButton(
              icon: Icon(Icons.edit, size: 22, color: Colors.grey[600]),
              tooltip: 'تعديل النصيحة',
              onPressed: () {
                Helpers.showCreateTipsBottomSheet(
                  context,
                  tipId: tip.id,
                  initialTip: tip.advice,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 22, color: Colors.grey[600]),
              tooltip: 'حذف النصيحة',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ShowAlertDialog(
                    title: 'هل تريد حذف النصيحة؟',
                    action: 'حذف',
                    onConfirmed: () async {
                      Navigator.of(context).pop();
                      await context.read<TipsCubit>().deleteTip(tip.id);
                    },
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shaty/core/extensions/localization_extension.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/user_type.dart';
// import '../../../core/utils/helpers/helpers.dart';
// import '../../../shared/widgets/labeled_text_field.dart';
// import 'dart:collection';
// import '../../../shared/widgets/show_alert_Dialog.dart';
// import '../cubit/tips_cubit.dart';
// import '../cubit/tips_state.dart';
// import '../data/models/tips_model.dart';
// import 'create_tips_bottom_sheet.dart';
//
// class TipsSection extends StatefulWidget {
//   const TipsSection({super.key});
//
//   @override
//   State<TipsSection> createState() => _TipsSectionState();
// }
//
// class _TipsSectionState extends State<TipsSection> {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<TipsCubit, TipsState>(
//       listener: (context, state) {
//         if (state.successMessage != null) {
//           Helpers.showToast(message: state.successMessage!);
//           context.read<TipsCubit>().clearMessages();
//         } else if (state.failureMessage != null) {
//           Helpers.showToast(message : state.failureMessage!);
//         }
//       },
//       builder: (context, state) {
//         final List<TipsModel> tips = state.tips.toList();
//         final displayedTips = tips.take(3).toList();
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     context.loc.daily_tips,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                   const Spacer(),
//                   /// زر عرض المزيد (اختياري حسب التصميم)
//                   if (displayedTips.length > 2)
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/view_tips');
//                       },
//                       child:  Text(
//                         context.loc.view_all,
//                         textAlign: TextAlign.end,
//                         style: TextStyle(
//                             fontSize: 14, color: AppColors.secondaryColor),
//                       ),
//                     ),
//                   if (UserType.isDoctor)
//                     IconButton(
//                       onPressed: () {
//                         Helpers.showCreateTipsBottomSheet(context);
//                       },
//                       icon: const Icon(Icons.add_circle,
//                           color: AppColors.primaryColor),
//                     ),
//                 ],
//               ),
//
//               const SizedBox(height: 10),
//
//               /// تحميل أو عرض النصائح
//               if (state.isLoading)
//                 const Center(child: CircularProgressIndicator())
//               else if (tips.isEmpty)
//                 const Center(child: Text("لا توجد نصائح حالياً"))
//               else
//                 ListView.separated(
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: displayedTips.length,
//                   shrinkWrap: true,
//                   separatorBuilder: (_, __) => const SizedBox(height: 10),
//                   itemBuilder: (context, index) {
//                     final tip = displayedTips[index];
//                     print('Displayed Tips: ${displayedTips}');
//                     print('Tips count: ${state.tips.length}');
//                     print('Tips count: ${state.tips.length}, Processing index: $index');
//                     return Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF9F9F9),
//                         borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12.withOpacity(0.05),
//                               blurRadius: 6,
//                               offset: const Offset(0, 3),
//                             ),
//                           ]
//                       ),
//                       child: Row(
//                         children: [
//                           // الحاجز الأزرق
//                           Container(
//                             width: 5,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               tip.advice,
//                               style: const TextStyle(fontSize: 16),
//                               // softWrap: true, // للتأكد من التفاف النص إذا كان طويلاً
//                             ),
//                           ),
//                           if (UserType.isDoctor) ...[
//                             IconButton(
//                               icon: const Icon(Icons.edit,
//                                   size: 20, color: Colors.grey),
//                               onPressed: () {
//                              Helpers.showCreateTipsBottomSheet(context,tipId: tip.id,initialTip: tip.advice);
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete_outline,
//                                   size: 20, color: Colors.grey),
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => ShowAlertDialog(
//                                     title: 'هل تريد حذف النصيحة؟',
//                                     // icon: Icons.delete,
//                                     action: 'حذف',
//                                     onConfirmed: () async {
//                                       Navigator.of(context).pop();
//                                       await  context.read<TipsCubit>().deleteTip(tip.id);
//
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//        //       SizedBox(height: 8,),
//
//             ],
//           ),
//         );
//       },
//     );
//   }
// // الدالة لعرض BottomSheet
//
// }
//

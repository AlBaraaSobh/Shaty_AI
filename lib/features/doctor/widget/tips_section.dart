import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/user_type.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/widgets/labeled_text_field.dart';
import 'dart:collection';
import '../../../shared/widgets/show_alert_Dialog.dart';
import '../cubit/tips_cubit.dart';
import '../cubit/tips_state.dart';
import '../data/models/tips_model.dart';
import 'create_tips_bottom_sheet.dart';

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
          Helpers.showToast(message : state.failureMessage!);
        }
      },
      builder: (context, state) {
        final List<TipsModel> tips = state.tips.toList();
        final displayedTips = tips.take(3).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  /// زر عرض المزيد (اختياري حسب التصميم)
                  if (displayedTips.length > 2)
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/view_tips');
                      },
                      child:  Text(
                        context.loc.view_all,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14, color: AppColors.secondaryColor),
                      ),
                    ),
                  if (UserType.isDoctor)
                    IconButton(
                      onPressed: () {
                        Helpers.showCreateTipsBottomSheet(context);
                      },
                      icon: const Icon(Icons.add_circle,
                          color: AppColors.primaryColor),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              /// تحميل أو عرض النصائح
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (tips.isEmpty)
                const Center(child: Text("لا توجد نصائح حالياً"))
              else
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedTips.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final tip = displayedTips[index];
                    print('Displayed Tips: ${displayedTips}');
                    print('Tips count: ${state.tips.length}');
                    print('Tips count: ${state.tips.length}, Processing index: $index');
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ]
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
                              tip.advice,
                              style: const TextStyle(fontSize: 16),
                              // softWrap: true, // للتأكد من التفاف النص إذا كان طويلاً
                            ),
                          ),
                          if (UserType.isDoctor) ...[
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  size: 20, color: Colors.grey),
                              onPressed: () {
                             Helpers.showCreateTipsBottomSheet(context,tipId: tip.id,initialTip: tip.advice);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 20, color: Colors.grey),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ShowAlertDialog(
                                    title: 'هل تريد حذف النصيحة؟',
                                    // icon: Icons.delete,
                                    action: 'حذف',
                                    onConfirmed: () async {
                                      Navigator.of(context).pop();
                                      await  context.read<TipsCubit>().deleteTip(tip.id);

                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
       //       SizedBox(height: 8,),

            ],
          ),
        );
      },
    );
  }
// الدالة لعرض BottomSheet

}


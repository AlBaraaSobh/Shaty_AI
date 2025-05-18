import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import 'package:shaty/features/doctor/cubit/tips_cubit.dart';
import 'package:shaty/features/doctor/cubit/tips_state.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/user_type.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/widgets/show_alert_Dialog.dart';
import '../data/models/tips_model.dart';

class ViewTips extends StatelessWidget {
  const ViewTips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TipsCubit, TipsState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          Helpers.showToast(message: state.successMessage!);
        } else if (state.failureMessage != null) {
          Helpers.showToast(message: state.failureMessage!);
        }
      },
      builder: (context, state) {
        final List<TipsModel> tips = state.tips.toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.loc.daily_tips,
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tips.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final tip = tips[index];

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(12),
                       //   border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
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
                                style: const TextStyle(fontSize: 16,height: 1.5),
            
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

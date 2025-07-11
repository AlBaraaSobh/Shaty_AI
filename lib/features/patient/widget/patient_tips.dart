import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import '../../../core/constants/app_colors.dart';
import '../../doctor/data/models/tips_model.dart';
import '../cubit/tips_patient_cubit.dart';
import '../cubit/tips_patient_state.dart';

class PatientTips extends StatefulWidget {
  const PatientTips({super.key});

  @override
  State<PatientTips> createState() => _PatientTipsState();
}

class _PatientTipsState extends State<PatientTips> {
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // تغيير النصيحة كل 5 ثواني
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final tips = context.read<TipsPatientCubit>().state.tips;
      if (tips.isNotEmpty) {
        setState(() {
          currentIndex = (currentIndex + 1) % tips.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // مهم جدًا
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            ],
          ),
          const SizedBox(height: 14),
          BlocBuilder<TipsPatientCubit, TipsPatientState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.tips.isEmpty) {
                return Center(
                  child: Text(
                    context.loc.no_tips,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                final tip = state.tips[currentIndex];
                return _buildTipItem(tip);
              }
            },
          ),
        ],
      ),
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
          Container(
            width: 6,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 16),
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
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shaty/core/localization/localization_extension.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../doctor/data/models/tips_model.dart';
// import '../cubit/tips_patient_cubit.dart';
// import '../cubit/tips_patient_state.dart';
//
//
// class PatientTips extends StatelessWidget {
//   const PatientTips({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TipsPatientCubit, TipsPatientState>(
//       builder: (context, state) {
//         final tips = state.tips;
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // رأس القسم
//               Row(
//                 children: [
//                   Text(
//                     context.loc.daily_tips,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.primaryColor,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//
//               const SizedBox(height: 14),
//
//               // المحتوى
//               if (state.isLoading)
//                 const Center(child: CircularProgressIndicator())
//               else if (state.error != null)
//                 Center(
//                   child: Text(
//                     "حدث خطأ أثناء جلب النصائح",
//                     style: TextStyle(
//                       color: Colors.red[700],
//                       fontSize: 15,
//                     ),
//                   ),
//                 )
//               else if (tips.isEmpty)
//                   Center(
//                     child: Text(
//                       "لا توجد نصائح حالياً",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 else
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: tips.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 14),
//                     itemBuilder: (context, index) {
//                       final tip = tips[index];
//                       return _buildTipItem(tip);
//                     },
//                   ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildTipItem(TipsModel tip) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(color: Colors.grey.withOpacity(0.15)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 6,
//             height: 48,
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               tip.advice,
//               style: const TextStyle(
//                 fontSize: 17,
//                 height: 1.4,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

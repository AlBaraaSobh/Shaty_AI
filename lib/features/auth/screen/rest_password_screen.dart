import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import '../../../shared/widgets/labeled_text_field.dart';
import '../../../shared/widgets/primary_button .dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';

class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  late TextEditingController _emailTextEditingController;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state.successMessage != null) {
              // ✅ عند نجاح إرسال الرمز، ننتقل إلى شاشة التحقق
              Navigator.pushNamed(
                context,
                '/verification_screen',
                arguments: _emailTextEditingController.text.trim(),
              );
            }
            if (state.failureMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failureMessage!)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.loc.reset_password_title,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    context.loc.reset_password_subtitle,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LabeledTextField(
                    label: context.loc.email,
                    hintText: context.loc.hint_email,
                    controller: _emailTextEditingController,
                  ),
                  const SizedBox(height: 25),
                  PrimaryButton(
                    label: context.loc.send_code,
                    onPressed: state.isLoading
                        ? null
                        : () {
                      final email = _emailTextEditingController.text.trim();
                      if (email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى إدخال البريد الإلكتروني')),
                        );
                        return;
                      }
                      // ✅ إرسال الرمز
                      context.read<ResetPasswordCubit>().sendEmailToReset(email);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shaty/core/constants/app_colors.dart';
// import 'package:shaty/core/localization/localization_extension.dart';
//
// import '../../../shared/widgets/labeled_text_field.dart';
// import '../../../shared/widgets/primary_button .dart';
//
//
// class RestPasswordScreen extends StatefulWidget {
//   const RestPasswordScreen({super.key});
//
//   @override
//   State<RestPasswordScreen> createState() => _RestPasswordScreenState();
// }
//
// class _RestPasswordScreenState extends State<RestPasswordScreen> {
//   late TextEditingController _emailTextEditingController;
//
//   @override
//   void initState() {
//     _emailTextEditingController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _emailTextEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 context.loc.reset_password_title,
//                 style: TextStyle(
//                     color: AppColors.primaryColor,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700),
//               ),
//               Text(
//                 context.loc.reset_password_subtitle,
//                 style: TextStyle(
//                     color: AppColors.secondaryColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               LabeledTextField(
//                   label: (context.loc.email),
//                   hintText: context.loc.hint_email,
//                   controller: _emailTextEditingController),
//               SizedBox(
//                 height: 25,
//               ),
//               PrimaryButton(label: context.loc.send_code,
//                 onPressed: () {
//                 Navigator.pushNamed(context, '/verification_screen');
//               },),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

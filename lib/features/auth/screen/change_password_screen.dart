import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/shared/widgets/labeled_text_field.dart';
import 'package:shaty/shared/widgets/primary_button .dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late String email;
  late String token;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    email = args['email']!;
    token = args['token']!;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تغيير كلمة المرور'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
              );
              Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (_) => false);
            }
            if (state.failureMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failureMessage!)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "الرجاء إدخال كلمة مرور جديدة",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 25),
                  LabeledTextField(
                    label: "كلمة المرور الجديدة",
                    hintText: "أدخل كلمة المرور الجديدة",
                    controller: _passwordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 20),
                  LabeledTextField(
                    label: "تأكيد كلمة المرور",
                    hintText: "أعد كتابة كلمة المرور",
                    controller: _confirmPasswordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    label: "إعادة تعيين",
                    onPressed: state.isLoading
                        ? null
                        : () {
                      final password = _passwordController.text.trim();
                      final confirmPassword = _confirmPasswordController.text.trim();

                      if (password.isEmpty || confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى ملء جميع الحقول')),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('كلمة المرور غير متطابقة')),
                        );
                        return;
                      }

                      context.read<ResetPasswordCubit>().resetPassword(
                        email: email,
                        newPassword: password,
                        token: token,
                      );
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
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shaty/core/utils/helpers/helpers.dart';
// import 'package:shaty/shared/widgets/change_password_form.dart';
// import 'package:shaty/features/shared/settings/cubit/change_password_cubit.dart';
// import 'package:shaty/features/shared/settings/cubit/change_password_state.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   late TextEditingController _oldPasswordController;
//   late TextEditingController _newPasswordController;
//   late TextEditingController _confirmNewPasswordController;
//
//   @override
//   void initState() {
//     _oldPasswordController = TextEditingController();
//     _newPasswordController = TextEditingController();
//     _confirmNewPasswordController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _oldPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmNewPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _handleConfirm() {
//     final oldPassword = _oldPasswordController.text.trim();
//     final newPassword = _newPasswordController.text.trim();
//     final confirmPassword = _confirmNewPasswordController.text.trim();
//
//     if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
//       Helpers.showToast(message: 'يرجى تعبئة جميع الحقول');
//       return;
//     }
//
//     if (newPassword != confirmPassword) {
//       Helpers.showToast(message: 'كلمتا المرور غير متطابقتين');
//       return;
//     }
//
//     if (newPassword.length < 6) {
//       Helpers.showToast(message: 'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
//       return;
//     }
//
//     context.read<ChangePasswordCubit>().changePassword(
//       lastPassword: oldPassword,
//       newPassword: newPassword,
//       confirmPassword: confirmPassword,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("تغيير كلمة المرور")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
//           listener: (context, state) {
//             if (state.successMessage != null) {
//               Helpers.showToast(message: state.successMessage!);
//               Navigator.pop(context); // إغلاق الصفحة بعد النجاح
//             } else if (state.failureMessage != null) {
//               Helpers.showToast(message: state.failureMessage!);
//             }
//           },
//           builder: (context, state) {
//             return Stack(
//               children: [
//                 ChangePasswordForm(
//                   oldPasswordController: _oldPasswordController,
//                   newPasswordController: _newPasswordController,
//                   confirmPasswordController: _confirmNewPasswordController,
//                   onConfirm: _handleConfirm,
//                 ),
//                 if (state.isLoading)
//                   const Center(child: CircularProgressIndicator()),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

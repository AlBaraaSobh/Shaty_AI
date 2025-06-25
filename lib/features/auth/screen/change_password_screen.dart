import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/utils/helpers/helpers.dart';
import 'package:shaty/shared/widgets/change_password_form.dart';
import 'package:shaty/features/shared/settings/cubit/change_password_cubit.dart';
import 'package:shaty/features/shared/settings/cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmNewPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Helpers.showToast(message: 'يرجى تعبئة جميع الحقول');
      return;
    }

    if (newPassword != confirmPassword) {
      Helpers.showToast(message: 'كلمتا المرور غير متطابقتين');
      return;
    }

    if (newPassword.length < 6) {
      Helpers.showToast(message: 'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      return;
    }

    context.read<ChangePasswordCubit>().changePassword(
      lastPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تغيير كلمة المرور")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state.successMessage != null) {
              Helpers.showToast(message: state.successMessage!);
              Navigator.pop(context); // إغلاق الصفحة بعد النجاح
            } else if (state.failureMessage != null) {
              Helpers.showToast(message: state.failureMessage!);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                ChangePasswordForm(
                  oldPasswordController: _oldPasswordController,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmNewPasswordController,
                  onConfirm: _handleConfirm,
                ),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}

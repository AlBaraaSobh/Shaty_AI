import 'package:flutter/material.dart';

import '../../../shared/widgets/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;
  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ChangePasswordForm(
            newPasswordController: _newPasswordController,
            confirmPasswordController: _confirmNewPasswordController,
            onConfirm: _handleConfirm),
      ),
    );
  }

  void _handleConfirm() {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmNewPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('context.loc.fill_all_fields')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('context.loc.passwords_do_not_match')),
      );
      return;
    }

    // TODO: ربط بـ Cubit
    print('New password confirmed');
  }
}
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// context.loc.new_password,
// style: TextStyle(
// color: AppColors.primaryColor, fontWeight: FontWeight.w500,
// fontSize: 25,
// ),
// ),
// const SizedBox(height: 25,),
// LabeledTextField(
// label: context.loc.password,
// hintText: context.loc.hint_password,
// controller: _newPasswordController,obscure: true,),
// const SizedBox(height: 25,),
// LabeledTextField(
// label: context.loc.confirm_password,
// hintText: context.loc.hint_confirm_password,
// controller: _confirmNewPasswordController,obscure: true,),
// const SizedBox(height: 40,),
// PrimaryButton(
// label: context.loc.confirm_password,
// onPressed: () {
// FocusScope.of(context).unfocus();
// final newPassword = _newPasswordController.text.trim();
// final confirmPassword =
// _confirmNewPasswordController.text.trim();
//
// if (newPassword.isEmpty || confirmPassword.isEmpty) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text(
// 'context.loc.fill_all_fields')),
// );
// return;
// }
//
// if (newPassword != confirmPassword) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text(
// 'context.loc.passwords_do_not_match')),
// );
// return;
// }
// print('New password confirmed');
// }),
// ],
// ),

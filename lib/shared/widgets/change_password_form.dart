import 'package:flutter/material.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import 'package:shaty/shared/widgets/primary_button%20.dart';

import '../../core/constants/app_colors.dart';
import 'labeled_text_field.dart';

class ChangePasswordForm extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onConfirm;
  const ChangePasswordForm(
      {super.key,
      required this.oldPasswordController,
      required this.newPasswordController,
      required this.confirmPasswordController,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.new_password,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 25),
          LabeledTextField(
            label: context.loc.current_password,
            hintText: '••••••••',
            obscure: true,
            controller: oldPasswordController,
          ),
          LabeledTextField(
            label: context.loc.new_password,
            hintText: '••••••••',
            obscure: true,
            controller: newPasswordController,
          ),
          const SizedBox(height: 25),
          LabeledTextField(
            label: context.loc.confirm_new_password,
            hintText: '••••••••',
            obscure: true,
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            label: context.loc.change_password,
            onPressed: onConfirm,
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

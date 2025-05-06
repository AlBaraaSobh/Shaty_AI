import 'package:flutter/material.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import 'labeled_text_field.dart';

class DoctorSignIn extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController specializationController;
  final TextEditingController jobNumberController;

  const DoctorSignIn(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.specializationController,
      required this.jobNumberController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledTextField(
          label: context.loc.enter_your_name,
          hintText: context.loc.hint_enter_your_name,
          controller: nameController,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.email,
          hintText: context.loc.hint_email,
          controller: emailController,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.password,
          hintText: context.loc.hint_password,
          controller: passwordController,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.confirm_password,
          hintText: context.loc.hint_confirm_password,
          controller: confirmPasswordController,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.job_number,
          hintText: context.loc.hint_job_number,
          controller: jobNumberController ,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.specialty_id,
          hintText: context.loc.hint_specialty_id,
          controller: specializationController,
        ),
      ],
    );
  }
}

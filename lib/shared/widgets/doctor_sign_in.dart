import 'package:flutter/material.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import 'package:shaty/core/utils/validators/validators.dart';
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
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.password,
          hintText: context.loc.hint_password,
          controller: passwordController,
          validator: Validators.validatePassword,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.confirm_password,
          hintText: context.loc.hint_confirm_password,
          controller: confirmPasswordController,
          validator: (value) {
            return   Validators.confirmPasswordValidator(value,passwordController.text);
          },
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.job_number,
          hintText: context.loc.hint_job_number,
          controller: jobNumberController ,
          validator: Validators.jobNumberValidator,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: context.loc.specialty_id,
          hintText: context.loc.hint_specialty_id,
          controller: specializationController,
          // validator: Validators.,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import 'labeled_text_field.dart';
class PatientSignIn extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController confirmPasswordController;
  final TextEditingController typeDiseaseController;

  const PatientSignIn(
      {super.key, required this.emailController,
      required this.passwordController,
      required this.nameController,
      required this.confirmPasswordController,
      required this.typeDiseaseController});

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
          label: context.loc.specialization,
          hintText: context.loc.hint_specialization,
          controller: typeDiseaseController,
        ),
      ],
    );

  }

}
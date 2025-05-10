import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/user_type.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import 'package:shaty/shared/widgets/labeled_text_field.dart';
import 'package:shaty/shared/widgets/primary_button%20.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/enums/user_role_enum.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../core/utils/validators/validators.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  bool _isDoctor = false;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isLoading) {
            Helpers.showLoadingDialog(context);
          } else if (state.successMessage != null && state.route != null) {
            Helpers.handleSuccess(context, state.successMessage!, route: state.route);
            context.read<LoginCubit>().clearMessages();
          } else if (state.failureMessage != null) {
            Helpers.handleFailure(context, state.failureMessage!);
            context.read<LoginCubit>().clearMessages();
          }

        },
        // listener: (context, state) {
        //   if (state.isLoading) {
        //     Helpers.showLoadingDialog(context);
        //   } else if (state.successMessage  != null && state.route != null) {
        //     Helpers.handleSuccess(context, state.successMessage !, route: state.route);
        //   } else if (state.failureMessage  != null) {
        //     Helpers.handleFailure(context, state.failureMessage !);
        //   }
        // },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.login_now,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 25),
                        LabeledTextField(
                          label: context.loc.email,
                          hintText: context.loc.hint_email,
                          controller: _emailTextEditingController,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        LabeledTextField(
                          label: context.loc.password,
                          hintText: context.loc.hint_password,
                          controller: _passwordTextEditingController,
                          obscure: true,
                          validator: Validators.validatePassword,
                        ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isDoctor,
                              onChanged: (value) {
                                setState(() {
                                  _isDoctor = value ?? false;
                                });
                              },
                            ),
                            Text(
                              context.loc.sign_in_doctor_title,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/rest_password_screen');
                          },
                          child: Text(
                            context.loc.forget_password,
                            style: TextStyle(
                                fontSize: 13, color: AppColors.accentColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      label: context.loc.login,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().loginCubit(
                            email: _emailTextEditingController.text,
                            password: _passwordTextEditingController.text,
                            role: _isDoctor ? UserRole.doctor : UserRole.patient,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/sign_in_screen');
                      },
                      child: Center(
                        child: Text(
                          context.loc.create_account,
                          style: TextStyle(
                              color: AppColors.secondaryColor, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

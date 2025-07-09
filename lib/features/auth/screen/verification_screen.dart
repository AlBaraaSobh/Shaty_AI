import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';

import '../../../shared/widgets/pin_code_input.dart';
import '../../../shared/widgets/primary_button .dart';
import '../../../shared/widgets/resend_code_timer.dart';
import '../cubit/reset_password_cubit.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _code = '';
  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    email = ModalRoute.of(context)!.settings.arguments as String;
  }

  void _onCodeCompleted(String code) {
    setState(() => _code = code);
  }

  void _onResendCode() {
    context.read<ResetPasswordCubit>().sendEmailToReset(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('أدخل الرمز'),
            const SizedBox(height: 20),
            PinCodeInput(onCompleted: _onCodeCompleted),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'تأكيد الرمز',
              onPressed: () async {
                if (_code.length != 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("يرجى إدخال الرمز الكامل")),
                  );
                  return;
                }
                try {
                  final token = await context.read<ResetPasswordCubit>().verifyCode(
                    email: email,
                    code: _code,
                  );
                  Navigator.pushNamed(
                    context,
                    '/change_password_screen',
                    arguments: {
                      'email': email,
                      'token': token,
                    },
                  );
                } catch (_) {}
              },
            ),
            const SizedBox(height: 20),
            ResendCodeTimer(onResend: _onResendCode),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';

import '../../../shared/widgets/pin_code_input.dart';
import '../../../shared/widgets/primary_button .dart';
import '../../../shared/widgets/resend_code_timer.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}


class _VerificationScreenState extends State<VerificationScreen> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.we_sent_code,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              PinCodeInput(onCompleted: _onCodeCompleted),
              SizedBox(
                height: 30,
              ),
              PrimaryButton(
                label: context.loc.confirm_code,
                onPressed: () {
                  Navigator.pushNamed(context, '/change_password_screen');
                },
              ),
              SizedBox(height: 25,),
              ResendCodeTimer(onResend: () {
                _onResendCode();
              },)
            ],
          ),
        ),
      ),
    );

  }

  void _onCodeCompleted(String code) {
    setState(() => _code = code);
  }

  void _onResendCode() {
    //TODO إعادة إرسال الرمز هنا
    print('رمز جديد تم إرساله');
  }

}

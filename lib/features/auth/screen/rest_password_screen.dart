import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import '../../../shared/widgets/labeled_text_field.dart';
import '../../../shared/widgets/primary_button .dart';


class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  late TextEditingController _emailTextEditingController;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.loc.reset_password_title,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                context.loc.reset_password_subtitle,
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              LabeledTextField(
                  label: (context.loc.email),
                  hintText: context.loc.hint_email,
                  controller: _emailTextEditingController),
              SizedBox(
                height: 25,
              ),
              PrimaryButton(label: context.loc.send_code,
                onPressed: () {
                Navigator.pushNamed(context, '/verification_screen');
              },),
            ],
          ),
        ),
      ),
    );
  }
}

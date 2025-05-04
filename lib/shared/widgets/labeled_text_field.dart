import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shaty/core/constants/app_colors.dart';

class LabeledTextField extends StatelessWidget {
  final String label ;
  final String hintText ;
  final TextEditingController controller ;
  final bool obscure ;

  LabeledTextField(
      {required this.label,
      required this.hintText,
      required this.controller,
       this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12,color: AppColors.secondaryColor)),
        SizedBox(height: 8,),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText:hintText,
            fillColor: AppColors.backGroundFieldColor,
            hintStyle: TextStyle(color: AppColors.accentColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8)
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';

class LabeledTextField extends StatelessWidget {
  final String label ;
  final String hintText ;
  final TextEditingController controller ;
  final bool obscure ;
  final String? Function(String?)? validator;

  const LabeledTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscure = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12,color: AppColors.secondaryColor)),
        SizedBox(height: 8,),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
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

import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';

class BuildSettingsTile extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final String title;

  const BuildSettingsTile({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 40,
          height: 40,decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
        child: Image.asset(icon ),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}

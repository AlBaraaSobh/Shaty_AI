import 'package:flutter/material.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import '../../../core/constants/app_colors.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(label: context.loc.followers, value: '120'),
        _StatItem(label: context.loc.tips, value: '15'),
        _StatItem(label: context.loc.articles, value: '10'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.primaryColor),),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

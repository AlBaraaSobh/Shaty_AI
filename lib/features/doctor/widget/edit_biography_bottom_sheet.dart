import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/shared/widgets/primary_button .dart';
import '../cubit/doctor_profile_cubit.dart';

class EditBiographyBottomSheet extends StatefulWidget {
  final String? initialBio;
  const EditBiographyBottomSheet({super.key, this.initialBio});

  @override
  State<EditBiographyBottomSheet> createState() => _EditBiographyBottomSheetState();
}

class _EditBiographyBottomSheetState extends State<EditBiographyBottomSheet> {
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.initialBio ?? '');
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  'تعديل السيرة الذاتية',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.secondaryColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bioController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'اكتب نبذتك الطبية هنا...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              label: 'حفظ التعديلات',
              onPressed: () {
                final bio = _bioController.text.trim();
                if (bio.isNotEmpty) {
                  BlocProvider.of<DoctorProfileCubit>(context).updateBio(bio);
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

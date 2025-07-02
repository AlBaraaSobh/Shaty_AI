import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/utils/helpers/helpers.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/shared/settings/cubit/edit_profile_cubit.dart';
import 'package:shaty/shared/widgets/primary_button%20.dart';
import '../cubit/edit_profile_state.dart';
import 'package:shaty/core/localization/localization_extension.dart';


class EditDoctorProfileScreen extends StatefulWidget {
  const EditDoctorProfileScreen({super.key});

  @override
  State<EditDoctorProfileScreen> createState() => _EditDoctorProfileScreenState();
}

class _EditDoctorProfileScreenState extends State<EditDoctorProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final specialtyNumberController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final profile = context.read<DoctorProfileCubit>().state.doctor;
    if (profile != null) {
      nameController.text = profile.name;
      emailController.text = profile.email;
      bioController.text = profile.bio ?? '';
      specialtyNumberController.text = profile.jobSpecialtyNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = context.read<DoctorProfileCubit>().state.doctor;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          Helpers.showToast(message: state.successMessage!);
          Navigator.pop(context);
          context.read<DoctorProfileCubit>().getDoctorProfile();
        } else if (state.failureMessage != null) {
          Helpers.showToast(message: state.failureMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: const BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            title:   Text(context.loc.edit_profile,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : (doctor?.img != null
                            ? NetworkImage(doctor!.img!.replaceAll('127.0.0.1', '10.0.2.2'))
                            : const AssetImage('images/doctor.png')) as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: _pickImage,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera_alt,
                              size: 22,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                 Text(context.loc.edit_profile, style: TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                _buildEditableField(label: context.loc.enter_your_name, controller: nameController),
                const SizedBox(height: 15),
                _buildEditableField(label: context.loc.biography, controller: bioController),
                const SizedBox(height: 15),
                _buildEditableField(label: context.loc.email, controller: emailController),
                const SizedBox(height: 15),
                _buildEditableField(label: context.loc.specialty_id, controller: specialtyNumberController),
                const SizedBox(height: 30),
                PrimaryButton(
                  label: 'حفظ التعديلات',
                  onPressed: () {
                    if (!state.isLoading) {
                      context.read<EditProfileCubit>().updateProfile(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        bio: bioController.text.trim(),
                        specialtyNumber: specialtyNumberController.text.trim(),
                        image: _selectedImage,
                      );
                    }
                  },
                ),
                if (state.isLoading) const SizedBox(height: 20),
                if (state.isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          textDirection: Directionality.of(context),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F6FA),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: const Icon(Icons.edit, color: Colors.grey, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }
}

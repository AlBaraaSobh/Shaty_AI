import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/utils/helpers/helpers.dart';
import 'package:shaty/shared/widgets/primary_button .dart';
import 'package:shaty/core/localization/localization_extension.dart';
import 'package:shaty/core/utils/helpers/storage_helper.dart';

class EditPatientProfileScreen extends StatefulWidget {
  const EditPatientProfileScreen({super.key});

  @override
  State<EditPatientProfileScreen> createState() => _EditPatientProfileScreenState();
}

class _EditPatientProfileScreenState extends State<EditPatientProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  File? _selectedImage;
  String? _networkImage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final name = await StorageHelper.getData('name');
    final email = await StorageHelper.getData('email');
    final img = await StorageHelper.getData('img');

    print('Name from prefs: $name');
    print('Email from prefs: $email');
    print('Image from prefs: $img');

    nameController.text = name ?? '';
    emailController.text = email ?? '';
    setState(() {
      // _imageUrl = img ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          context.loc.edit_profile,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                        : (_networkImage != null && _networkImage!.isNotEmpty
                        ? NetworkImage(_networkImage!.replaceAll('127.0.0.1', '10.0.2.2'))
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
                        child: Icon(Icons.camera_alt, size: 22, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildEditableField(label: context.loc.enter_your_name, controller: nameController),
            const SizedBox(height: 15),
            _buildEditableField(label: context.loc.email, controller: emailController),
            const SizedBox(height: 30),
            PrimaryButton(
              label: context.loc.save,
              onPressed: () {
                Helpers.showToast(message: 'تم حفظ التعديلات محليًا (SharedPrefs)');
              },
            ),
          ],
        ),
      ),
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
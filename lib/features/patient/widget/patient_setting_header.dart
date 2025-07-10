import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/localization_extension.dart';
import '../../../core/utils/helpers/storage_helper.dart';

class PatientSettingHeader extends StatefulWidget {
  const PatientSettingHeader({super.key});

  @override
  State<PatientSettingHeader> createState() => _PatientSettingHeaderState();
}

class _PatientSettingHeaderState extends State<PatientSettingHeader> {
  String? name;
  String? email;
  String? img;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    final storedName = await StorageHelper.getData('name');
    final storedEmail = await StorageHelper.getData('email');
    final storedImg = await StorageHelper.getData('img');
    print('📦 name: $storedName');
    print('📦 email: $storedEmail');
    print('📦 img: $storedImg');
    setState(() {
      name = storedName;
      email = storedEmail;
      img = storedImg;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ImageProvider<Object> avatarImage = (img != null && img!.isNotEmpty)
        ? NetworkImage(img!.replaceAll('127.0.0.1', '10.0.2.2'))
        : const AssetImage('images/doctor.png');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: avatarImage,
            ),
            Positioned(
              bottom: 3,
              right: 1,
              child: InkWell(
                onTap: () {
                  // اختيار صورة من الكاميرا أو المعرض
                },
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // نفس اختيار الصورة
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name ?? 'لا توجد بيانات',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Text(
          email ?? '',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size(144, 36),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/edit_patient_profile_screen');
          },
          child: Text(
            context.loc.edit_profile,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

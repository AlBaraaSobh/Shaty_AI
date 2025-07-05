import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import '../cubit/patient_doctors_cubit.dart';
import '../cubit/patient_doctors_state.dart';
import '../widget/doctor_card.dart';

enum DoctorsViewType { specialties, following }

class PatientDoctorsScreen extends StatefulWidget {
  const PatientDoctorsScreen({Key? key}) : super(key: key);

  @override
  State<PatientDoctorsScreen> createState() => _PatientDoctorsScreenState();
}

class _PatientDoctorsScreenState extends State<PatientDoctorsScreen> {
  DoctorsViewType selectedView = DoctorsViewType.specialties;
  int? selectedSpecialtyIndex;

  final List<Map<String, dynamic>> specialties = [
    {'id': 10, 'name': 'أمراض القلب والشرايين'},
    {'id': 11, 'name': 'الجراحة العامة'},
    {'id': 12, 'name': 'الأمراض الباطنية'},
    {'id': 13, 'name': 'الأمراض الجلدية'},
    {'id': 14, 'name': 'الأمراض العصبية'},
    {'id': 15, 'name': 'الأمراض النفسية'},
    {'id': 16, 'name': 'الأمراض النسائية والولادة'},
    {'id': 17, 'name': 'الأطفال'},
    {'id': 18, 'name': 'الأورام'},
  ];

  @override
  void initState() {
    super.initState();
    _loadFollowedDoctors();
  }

  void _loadFollowedDoctors() {
    context.read<PatientDoctorsCubit>().getAllDoctors();
  }

  void _onSpecialtySelected(int index) {
    setState(() {
      if (selectedSpecialtyIndex == index) {
        selectedSpecialtyIndex = null;
      } else {
        selectedSpecialtyIndex = index;
        final specialtyId = specialties[index]['id'] as int;
        context.read<PatientDoctorsCubit>().getDoctorsBySpecialty(specialtyId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأطباء')),
      body: BlocBuilder<PatientDoctorsCubit, PatientDoctorsState>(
        builder: (context, state) {
          if (state.isLoading && state.doctors.isEmpty && selectedView == DoctorsViewType.following) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const SizedBox(height: 12),
              _buildToggleButtons(),
              const SizedBox(height: 16),
              Expanded(
                child: selectedView == DoctorsViewType.specialties
                    ? _buildSpecialtiesView(state)
                    : _buildFollowingView(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildToggleButton(
              text: 'التخصصات',
              isSelected: selectedView == DoctorsViewType.specialties,
              onTap: () {
                setState(() => selectedView = DoctorsViewType.specialties);
              },
              isRight: true,
            ),
            _buildToggleButton(
              text: 'المتابَعين',
              isSelected: selectedView == DoctorsViewType.following,
              onTap: () {
                setState(() => selectedView = DoctorsViewType.following);
                _loadFollowedDoctors();
              },
              isRight: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isRight,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor.withOpacity(0.9) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: isRight ? const Radius.circular(12) : Radius.zero,
              bottomRight: isRight ? const Radius.circular(12) : Radius.zero,
              topLeft: !isRight ? const Radius.circular(12) : Radius.zero,
              bottomLeft: !isRight ? const Radius.circular(12) : Radius.zero,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtiesView(PatientDoctorsState state) {
    return ListView.builder(
      itemCount: specialties.length,
      itemBuilder: (context, index) {
        final isSelected = selectedSpecialtyIndex == index;
        final doctorsForSpecialty = isSelected ? state.doctors : [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('${index + 1}. ${specialties[index]['name']}'),
              trailing: Icon(
                isSelected ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left,
              ),
              onTap: () => _onSpecialtySelected(index),
            ),
            if (isSelected)
              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (doctorsForSpecialty.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text('لا يوجد أطباء حالياً لهذا التخصص')),
                )
              else
                Column(
                  children: doctorsForSpecialty.map((doctor) {
                    return DoctorCard(
                      doctor: {
                        'name': doctor.name,
                        'email': doctor.email,
                        'image': doctor.image,
                      },
                      isFollowed: doctor.isFollowed,
                      buttonText: doctor.isFollowed ? 'إلغاء المتابعة' : 'متابعة',
                      buttonColor: doctor.isFollowed ? Colors.red : AppColors.primaryColor,
                      onButtonPressed: () {
                        context.read<PatientDoctorsCubit>().toggleFollowDoctor(doctor.id);
                      },
                    );
                  }).toList(),
                ),
          ],
        );
      },
    );
  }

  Widget _buildFollowingView(PatientDoctorsState state) {
    if (state.followedDoctors.isEmpty) {
      return const Center(
        child: Text('لم تقم بمتابعة أي طبيب بعد'),
      );
    }

    return ListView.builder(
      itemCount: state.followedDoctors.length,
      itemBuilder: (context, index) {
        final doctor = state.followedDoctors[index];
        return DoctorCard(
          doctor: {
            'name': doctor.name,
            'email': doctor.email,
            'image': doctor.image,
          },
          isFollowed: true,
          buttonText: 'إلغاء المتابعة',
          buttonColor: Colors.red,
          onButtonPressed: () {
            context.read<PatientDoctorsCubit>().toggleFollowDoctor(doctor.id);
          },
        );
      },
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// child: Container(
// decoration: BoxDecoration(
// color: const Color(0xFFF5F7FA), // رمادي-أبيض ناعم جدًا
// borderRadius: BorderRadius.circular(12),
// ),
// child: Row(
// children: [
// Expanded(
// child: TextButton(
// onPressed: () => setState(() => selectedView = DoctorsViewType.specialties),
// style: TextButton.styleFrom(
// backgroundColor: selectedView == DoctorsViewType.specialties
// ? AppColors.primaryColor.withOpacity(0.12) // أزرق ناعم جدًا
//     : Colors.transparent,
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(12),
// bottomRight: Radius.circular(12),
// ),
// ),
// padding: const EdgeInsets.symmetric(vertical: 14),
// ),
// child: Text(
// 'التخصصات',
// style: TextStyle(
// color: selectedView == DoctorsViewType.specialties
// ? AppColors.primaryColor
//     : Colors.grey[800],
// fontWeight: FontWeight.w600,
// fontSize: 15,
// ),
// ),
// ),
// ),
// Expanded(
// child: TextButton(
// onPressed: () => setState(() => selectedView = DoctorsViewType.following),
// style: TextButton.styleFrom(
// backgroundColor: selectedView == DoctorsViewType.following
// ? AppColors.primaryColor.withOpacity(0.12)
//     : Colors.transparent,
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(12),
// bottomLeft: Radius.circular(12),
// ),
// ),
// padding: const EdgeInsets.symmetric(vertical: 14),
// ),
// child: Text(
// 'المتابَعين',
// style: TextStyle(
// color: selectedView == DoctorsViewType.following
// ? AppColors.primaryColor
//     : Colors.grey[800],
// fontWeight: FontWeight.w600,
// fontSize: 15,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),

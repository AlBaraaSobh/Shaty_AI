import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';
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
  int? loadingSpecialtyId;

  final List<Map<String, dynamic>> specialties = [
    {'id': 1, 'name': 'أمراض القلب والشرايين'},
    {'id': 2, 'name': 'الجراحة العامة'},
    {'id': 3, 'name': 'الأمراض الباطنية'},
    {'id': 4, 'name': 'الأمراض الجلدية'},
    {'id': 5, 'name': 'الأمراض العصبية'},
    {'id': 6, 'name': 'الأمراض النفسية'},
    {'id': 7, 'name': 'الأمراض النسائية والولادة'},
    {'id': 8, 'name': 'الأطفال'},
    {'id': 9, 'name': 'الأورام'},
    {'id': 10, 'name': 'الأعصاب والجراحة العصبية'},
  ];

  void _onSpecialtySelected(int index) {
    final specialtyId = specialties[index]['id'] as int;

    if (selectedSpecialtyIndex == index) {
      setState(() {
        selectedSpecialtyIndex = null;
      });
    } else {
      setState(() {
        selectedSpecialtyIndex = index;
        loadingSpecialtyId = specialtyId;
      });
      context.read<PatientDoctorsCubit>().getDoctorsBySpecialty(specialtyId.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PatientDoctorsCubit>().getFollowedDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(context.loc.doctors,textAlign: TextAlign.center,),),
      body: BlocBuilder<PatientDoctorsCubit, PatientDoctorsState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 12),
              _buildToggleButtons(),
              const SizedBox(height: 16),
              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
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
      child: Row(
        children: [
          _buildToggleButton(
            text: context.loc.specialties,
            isSelected: selectedView == DoctorsViewType.specialties,
            onTap: () {
              setState(() => selectedView = DoctorsViewType.specialties);
            },
          ),
          _buildToggleButton(
            text: context.loc.followers,
            isSelected: selectedView == DoctorsViewType.following,
            onTap: () {
              setState(() => selectedView = DoctorsViewType.following);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryColor : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 3,
              width: 60,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }




  // Widget _buildToggleButton({
  //   required String text,
  //   required bool isSelected,
  //   required VoidCallback onTap,
  //   required bool isRight,
  // }) {
  //   return Expanded(
  //     child: GestureDetector(
  //       onTap: onTap,
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 200),
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //         decoration: BoxDecoration(
  //           color: isSelected ? Colors.transparent : Colors.transparent,
  //           border: Border(
  //             bottom: BorderSide(
  //               color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
  //               width: 2.5,
  //             ),
  //           ),
  //         ),
  //         child: Center(
  //           child: Text(
  //             text,
  //             style: TextStyle(
  //               color: isSelected ? AppColors.primaryColor : Colors.grey[600],
  //               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
  //               fontSize: 15,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }


  //
  // Widget _buildToggleButtons() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Row(
  //         children: [
  //           _buildToggleButton(
  //             text: 'التخصصات',
  //             isSelected: selectedView == DoctorsViewType.specialties,
  //             onTap: () {
  //               setState(() => selectedView = DoctorsViewType.specialties);
  //             },
  //             isRight: true,
  //           ),
  //           _buildToggleButton(
  //             text: 'المتابَعين',
  //             isSelected: selectedView == DoctorsViewType.following,
  //             onTap: () {
  //               setState(() => selectedView = DoctorsViewType.following);
  //             },
  //             isRight: false,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildToggleButton({
  //   required String text,
  //   required bool isSelected,
  //   required VoidCallback onTap,
  //   required bool isRight,
  // }) {
  //   return Expanded(
  //     child: TextButton(
  //       onPressed: onTap,
  //       style: TextButton.styleFrom(
  //         backgroundColor: isSelected ? Colors.blue.withOpacity(0.9) : Colors.transparent,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topRight: isRight ? const Radius.circular(12) : Radius.zero,
  //             bottomRight: isRight ? const Radius.circular(12) : Radius.zero,
  //             topLeft: !isRight ? const Radius.circular(12) : Radius.zero,
  //             bottomLeft: !isRight ? const Radius.circular(12) : Radius.zero,
  //           ),
  //         ),
  //         padding: const EdgeInsets.symmetric(vertical: 14),
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           color: isSelected ? Colors.white : AppColors.primaryColor,
  //           fontWeight: FontWeight.w600,
  //           fontSize: 15,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSpecialtiesView(PatientDoctorsState state) {
    return ListView.builder(
      itemCount: specialties.length,
      itemBuilder: (context, index) {
        final isSelected = selectedSpecialtyIndex == index;
        final specialtyId = specialties[index]['id'] as int;

        final doctorsForSpecialty = state.specialtyDoctors[specialtyId.toString()] ?? [];

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
              if (state.isLoading && loadingSpecialtyId == specialtyId)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (doctorsForSpecialty.isEmpty)
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: Text(context.loc.no_doctors_for_this_specialty)),
                )
              else
                Column(
                  children: doctorsForSpecialty.map((doctor) {
                    return DoctorCard(
                      doctor: doctor,
                      isFollowed: doctor.isFollowed,
                      buttonText: doctor.isFollowed ? context.loc.un_follow : context.loc.follow,
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
      return  Center(child: Text(context.loc.not_followed));
    }

    return ListView.builder(
      itemCount: state.followedDoctors.length,
      itemBuilder: (context, index) {
        final doctor = state.followedDoctors[index];
        return DoctorCard(
          doctor: doctor,
          isFollowed: doctor.isFollowed,
          buttonText: doctor.isFollowed ? context.loc.un_follow : context.loc.follow,
          buttonColor: doctor.isFollowed ? Colors.red : AppColors.primaryColor,
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

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

  void _onSpecialtySelected(int index, List<Map<String, dynamic>> specialties) {
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
    final specialties = _localizedSpecialties(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.doctors,
          textAlign: TextAlign.center,
        ),
      ),
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
                    ? _buildSpecialtiesView(state, specialties)
                    : _buildFollowingView(state),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _localizedSpecialties(BuildContext context) {
    return [
      {'id': 1, 'name': context.loc.specialty_cardiology},
      {'id': 2, 'name': context.loc.specialty_surgery},
      {'id': 3, 'name': context.loc.specialty_internal},
      {'id': 4, 'name': context.loc.specialty_dermatology},
      {'id': 5, 'name': context.loc.specialty_neurology},
      {'id': 6, 'name': context.loc.specialty_psychiatry},
      {'id': 7, 'name': context.loc.specialty_gynecology},
      {'id': 8, 'name': context.loc.specialty_pediatrics},
      {'id': 9, 'name': context.loc.specialty_oncology},
      {'id': 10, 'name': context.loc.specialty_neurosurgery},
    ];
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

  Widget _buildSpecialtiesView(
      PatientDoctorsState state,
      List<Map<String, dynamic>> specialties,
      ) {
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
              onTap: () => _onSpecialtySelected(index, specialties),
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
                  child: Center(
                    child: Text(context.loc.no_doctors_for_this_specialty),
                  ),
                )
              else
                Column(
                  children: doctorsForSpecialty.map((doctor) {
                    return DoctorCard(
                      doctor: doctor,
                      isFollowed: doctor.isFollowed,
                      buttonText:
                      doctor.isFollowed ? context.loc.un_follow : context.loc.follow,
                      buttonColor:
                      doctor.isFollowed ? Colors.red : AppColors.primaryColor,
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
      return Center(child: Text(context.loc.not_followed));
    }

    return ListView.builder(
      itemCount: state.followedDoctors.length,
      itemBuilder: (context, index) {
        final doctor = state.followedDoctors[index];
        return DoctorCard(
          doctor: doctor,
          isFollowed: doctor.isFollowed,
          buttonText:
          doctor.isFollowed ? context.loc.un_follow : context.loc.follow,
          buttonColor:
          doctor.isFollowed ? Colors.red : AppColors.primaryColor,
          onButtonPressed: () {
            context.read<PatientDoctorsCubit>().toggleFollowDoctor(doctor.id);
          },
        );
      },
    );
  }
}

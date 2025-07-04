import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import 'package:shaty/features/auth/cubit/doctor_register_cubit.dart';
import 'package:shaty/features/auth/cubit/doctor_register_state.dart';
import 'package:shaty/features/auth/cubit/patient_register_cubit.dart';
import '../../../controllers/sign_in_controllers.dart';
import '../../../core/enums/user_role_enum.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/widgets/doctor_sign_in.dart';
import '../../../shared/widgets/patient_sign_in.dart';
import '../../../shared/widgets/primary_button .dart';
import '../../../shared/widgets/toggle_user_role.dart';
import '../cubit/patient_register_state.dart';
import '../data/models/doctor_register_model.dart';
import '../data/models/patient_register_model .dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  UserRole _selectedRole = UserRole.patient;
  final _controllers = SignInControllers();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PatientRegisterCubit, PatientRegisterState>(
          listener: (context, state) {
            if (state.isLoading) {
              Helpers.handleLoading(context);
            } else if (state.successMessage !=null) {
              Helpers.handleSuccess(context, state.successMessage!, route: '/login');

            } else if (state.failureMessage!=null) {
              Helpers.handleFailure(context, state.failureMessage!);
            }
          },
        ),
        BlocListener<DoctorRegisterCubit, DoctorRegisterState>(
          listener: (context, state) {
            if (state.isLoading) {
              Helpers.handleLoading(context);
            } else if (state.successMessage !=null) {
              Helpers.handleSuccess(context, state.successMessage!, route: '/login_screen');
            } else if (state.failureMessage!=null) {
              Helpers.handleFailure(context, state.failureMessage!);
            }
          },
        ),
      ],
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.welcome_to_create_an_Account,
                      style: TextStyle(
                          fontSize: 20, color: AppColors.primaryColor),
                    ),
                    SizedBox(height: 25,),

                    RoleSelector(
                      selectedRole: _selectedRole,
                      onChanged: (role) {
                        setState(() {
                          _selectedRole = role;
                        });
                      },
                    ),

                    _selectedRole == UserRole.patient
                        ? PatientSignIn(
                        emailController: _controllers.email,
                        passwordController: _controllers.password,
                        nameController: _controllers.name,
                        confirmPasswordController: _controllers.confirmPassword,
                        typeDiseaseController: _controllers.typeDisease,
                    )
                        : DoctorSignIn(
                        emailController: _controllers.email,
                        passwordController: _controllers.password,
                        nameController: _controllers.name,
                        confirmPasswordController: _controllers.confirmPassword,
                        specializationController: _controllers.specialization,
                        jobNumberController: _controllers.jobNumber),
                    SizedBox(height: 50,),
                    PrimaryButton(
                      label: context.loc.create_account,
                      onPressed: () {

                        if (_selectedRole == UserRole.patient) {
                          // patient
                          if(_formKey.currentState!.validate()){
                            final patient = PatientRegisterModel(
                              name: _controllers.name.text.trim(),
                              email: _controllers.email.text.trim(),
                              password: _controllers.password.text.trim(),
                              passwordConfirmation:
                              _controllers.confirmPassword.text.trim(),
                              isDoctor: false,
                            );
                            print('Patient data to send: ${patient.toJson()}');
                            context.read<PatientRegisterCubit>()
                                .registerPatientCubit(patient);
                          }
                        } else {
                          if (_formKey.currentState!.validate()) {
                            final doctor = DoctorRegisterModel(
                              name: _controllers.name.text.trim(),
                              email: _controllers.email.text.trim(),
                              password: _controllers.password.text.trim(),
                              passwordConfirmation:
                                  _controllers.confirmPassword.text.trim(),
                              isDoctor: true,
                              jobSpecialtyNumber:
                                  _controllers.jobNumber.text.trim(),
                              specialtyId:
                                  _controllers.specialization.text.trim(),
                            );
                            print('Doctor data to send: ${doctor.toJson()}');
                            context
                                .read<DoctorRegisterCubit>()
                                .registerDoctorCubit(doctor);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
// Center(
//   child: ToggleButtons(
//     isSelected: [_selectedRole == UserRole.patient, _selectedRole == UserRole.doctor],
//     onPressed: (index) {
//       setState(() {
//         _selectedRole = index == 0 ? UserRole.patient : UserRole.doctor;
//       });
//     },
//     constraints: BoxConstraints(
//       minWidth: 168,
//       minHeight: 45,
//     ),
//     borderRadius: BorderRadius.circular(12),
//     selectedColor: Colors.white,
//     fillColor: AppColors.primaryColor,
//
//     children: [
//       Text(AppLocalizations.of(context)!.sign_in_patient_title,textAlign: TextAlign.center,),
//       Text(AppLocalizations.of(context)!.sign_in_doctor_title,textAlign: TextAlign.center,),
//     ],
//
//   ),
// ),
//***********
// ElevatedButton(
// onPressed: () {
// if (_selectedRole == UserRole.patient) {
// // patient
// } else {
// // doctor
// }
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: AppColors.primaryColor,
// minimumSize: Size(double.infinity, 50),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8)
// ),
// ),
// child: Text(
// AppLocalizations.of(context)!.create_account,
// style: TextStyle(color: Colors.white),
// ),),

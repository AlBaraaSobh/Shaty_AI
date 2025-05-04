import 'package:flutter/material.dart';

class SignInControllers {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final confirmPassword = TextEditingController();
  final typeDisease = TextEditingController();      // Patient only
  final jobNumber = TextEditingController();        // Doctor only
  final specialization = TextEditingController();   // Doctor only

  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    confirmPassword.dispose();
    typeDisease.dispose();
    jobNumber.dispose();
    specialization.dispose();
  }
}
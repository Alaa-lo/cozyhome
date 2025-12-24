import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/features/auth/screens/otpverificationscreen.dart';

class RegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String accountType = "renter";

  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fullName", nameController.text);
    await prefs.setString("email", emailController.text);
    await prefs.setString("password", passwordController.text);
    await prefs.setString("accountType", accountType);
    await prefs.setBool("registered", true);
  }

  Future<void> signUp(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showError(context, "Please fill all fields");
      return;
    }

    if (passwordController.text.length < 6) {
      showError(context, "Password must be at least 6 characters");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showError(context, "Passwords do not match");
      return;
    }

    await saveUserData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OTPVerificationScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/features/auth/screens/otpverificationscreen.dart';

class RegisterController {
  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Default account type
  String accountType = "renter"; // renter OR owner

  // Show error message
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Save user data locally
  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("fullName", nameController.text);
    await prefs.setString("email", emailController.text);
    await prefs.setString("password", passwordController.text);

    // ⭐ أهم سطر: حفظ نوع الحساب
    await prefs.setString("accountType", accountType);

    await prefs.setBool("registered", true);
  }

  // Sign Up logic
  Future<void> signUp(BuildContext context) async {
    // Validation
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

    // Save data
    await saveUserData();

    // Navigate to OTP screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OTPVerificationScreen()),
    );
  }
}

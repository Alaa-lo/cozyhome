import 'package:cozy_home_1/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Sign Up logic (API Version)
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

    try {
      // Save data locally and proceed to personal info
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', nameController.text);
      await prefs.setString('phonenumber', emailController.text); // Using email as phone for now
      await prefs.setString('password', passwordController.text);
      await prefs.setString('accountType', accountType);

      Navigator.pushNamed(context, "/personalInfo");
    } catch (e) {
      showError(context, "Something went wrong. Please try again.");
    }
  }
}

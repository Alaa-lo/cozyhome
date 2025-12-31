import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRegisterController {
  // Text Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Admin account type (fixed)
  String accountType = "admin";

  // Show error message
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Sign Up logic (API Version)
  Future<void> signUp(BuildContext context) async {
    // Validation
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showError(context, "Please fill all fields");
      return;
    }

    if (passwordController.text.length < 8) {
      showError(context, "Password must be at least 8 characters");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showError(context, "Passwords do not match");
      return;
    }

    try {
      // Save data locally and proceed to personal info
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('first_name', firstNameController.text);
      await prefs.setString('last_name', lastNameController.text);
      await prefs.setString('phonenumber', phoneController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setString('accountType', accountType); // Always "admin"

      // Navigate to personal info screen
      Navigator.pushNamed(context, "/admin_login");
    } catch (e) {
      print(e);
      showError(context, "Something went wrong. Please try again.");
    }
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}

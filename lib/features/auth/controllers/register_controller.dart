import 'package:cozy_home_1/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

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
      // Call API
      final response = await AuthService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        accountType: accountType,
      );

      print("REGISTER RESPONSE: $response");

      // Laravel returns: { message: "...", user: {...} }
      if (response["user"] != null) {
        // Navigate to next screen
        Navigator.pushNamed(context, "/personalInfo");
      } else {
        showError(context, response["message"] ?? "Registration failed");
      }
    } catch (e) {
      showError(context, "Something went wrong. Please try again.");
    }
  }
}

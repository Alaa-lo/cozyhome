import 'package:cozy_home_1/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  // Text Controllers
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Default account type (role)
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
    if (fullnameController.text.isEmpty ||
        phoneController.text.isEmpty ||
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
      print("SIGNUP CLICKED");
      print("SENDING REQUEST TO API...");

      // Call API
      final response = await AuthService.register(
        fullname: fullnameController.text,
        phonenumber: phoneController
            .text, // سيتم تحويله إلى mobile_number داخل AuthService
        password: passwordController.text,
        role: accountType,
      );

      print("REGISTER RESPONSE: $response");

      // Laravel returns: { message: "...", user: {...} }
      if (response["user"] != null) {
        // Save token if exists
        if (response["access_token"] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", response["access_token"]);
        }

        // Navigate to next screen (Personal Info)
        Navigator.pushNamed(context, "/personalInfo");
      } else {
        showError(context, response["message"] ?? "Registration failed");
      }
    } catch (e) {
      print("ERROR IN SIGNUP: $e");
      showError(context, "Something went wrong. Please try again.");
      print("ERROR DETAILS: $e");
    }
  }
}

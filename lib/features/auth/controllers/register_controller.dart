import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String accountType = "renter";

  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> signUp(BuildContext context) async {
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
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('firstName', firstNameController.text);
      await prefs.setString('lastName', lastNameController.text);
      await prefs.setString('phonenumber', phoneController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setString('accountType', accountType);

      // حفظ fullname
      await prefs.setString(
        'fullname',
        "${firstNameController.text} ${lastNameController.text}",
      );

      Navigator.pushNamed(context, "/personalInfo");
    } catch (e) {
      showError(context, "Something went wrong. Please try again.");
    }
  }
}

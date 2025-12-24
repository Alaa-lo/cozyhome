import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/features/renter/screens/homepage.dart';
import 'package:cozy_home_1/features/auth/screens/personalinfoscreen.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setBool('loggedIn', true);
  }

  Future<void> login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    String userId = emailController.text.replaceAll(".", "_");
    final prefs = await SharedPreferences.getInstance();
    bool completed = prefs.getBool("profileCompleted_$userId") ?? false;

    await saveLoginData();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful ✅")));

    if (completed) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RenterHomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PersonalInfoScreen(userId: userId)),
      );
    }
  }
}

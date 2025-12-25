import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/features/renter/screens/homepage.dart';
import 'package:cozy_home_1/features/auth/screens/personalinfoscreen.dart';
import 'package:cozy_home_1/features/owner/screens/owner_home_screen.dart';

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

    final prefs = await SharedPreferences.getInstance();

    // ⭐ قراءة نوع الحساب
    String? accountType = prefs.getString("accountType");

    // ⭐ تجهيز userId
    String userId = emailController.text.replaceAll(".", "_");

    // ⭐ قراءة حالة إكمال الملف الشخصي
    bool completed = prefs.getBool("profileCompleted_$userId") ?? false;

    await saveLoginData();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful ✅")));

    // ⭐ إذا كان المستخدم مالك شقة
    if (accountType == "owner") {
      if (completed) {
        // ✔ المالك أكمل ملفه → يروح على Home المالك
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OwnerHomeScreen()),
        );
      } else {
        // ✔ أول مرة → يروح على PersonalInfoScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PersonalInfoScreen(userId: userId)),
        );
      }
      return;
    }

    // ⭐ إذا كان المستخدم مستأجر
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

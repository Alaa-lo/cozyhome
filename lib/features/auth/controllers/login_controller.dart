import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/features/renter/screens/homepage.dart';
import 'package:cozy_home_1/features/owner/screens/owner_home_screen.dart';
import 'package:cozy_home_1/features/auth/screens/pendingapprovalscreen.dart';
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

    final prefs = await SharedPreferences.getInstance();

    // ⭐ قراءة نوع الحساب
    String? accountType = prefs.getString("accountType");

    // ⭐ قراءة حالة إكمال الملف الشخصي
    bool profileCompleted = prefs.getBool("profileCompleted") ?? false;

    // ⭐ قراءة حالة موافقة الأدمن
    bool adminApproved = prefs.getBool("adminApproved") ?? false;

    await saveLoginData();

    // ⭐ إذا الملف الشخصي غير مكتمل → يرجع على Personal Info
    if (!profileCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PersonalInfoScreen()),
      );
      return;
    }

    // ⭐ إذا الملف مكتمل لكن الأدمن لم يوافق → Pending Approval
    if (!adminApproved) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PendingApprovalScreen()),
      );
      return;
    }

    // ⭐ إذا كل شيء تمام → يدخل حسب نوع الحساب
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful ✅")));

    if (accountType == "owner") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OwnerHomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RenterHomeScreen()),
      );
    }
  }
}

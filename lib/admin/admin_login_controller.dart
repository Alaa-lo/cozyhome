import 'package:flutter/material.dart';
import 'package:cozy_home_1/admin/admin_service.dart';
import 'package:cozy_home_1/admin/admin_dashboard.dart';
import '../features/auth/models/user.dart';

class AdminLoginController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final AdminService _adminService = AdminService();

  Future<void> login(BuildContext context) async {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    try {
      // استدعاء ميثود تسجيل دخول الأدمن مع إرسال البيانات المطلوبة
      User? user = await _adminService.loginAdmin(
        phoneController.text,
        passwordController.text,
      );

      if (user != null) {
        if (user.role.toLowerCase() == "admin") {
          debugPrint("ADMIN LOGIN SUCCESS: AdminService returned admin user.");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminDashboard()),
          );
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Access denied. Admin credentials required."),
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Admin Login Failed")));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
  }
}

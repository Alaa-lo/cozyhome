import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozy_home_1/features/auth/screens/login.dart';

class PendingApprovalController {
  bool approvalNotified = false; // ⭐ لمعرفة إذا عرضنا السناك بار ولا لأ

  Future<bool> checkAdminApproval() async {
    final prefs = await SharedPreferences.getInstance();

    // fake delay
    await Future.delayed(const Duration(seconds: 2));

    bool approved = prefs.getBool("adminApproved") ?? false;
    return approved;
  }

  Future<void> checkStatus(BuildContext context) async {
    bool approved = await checkAdminApproval();

    if (approved) {
      // ⭐ أول مرة: بس نعرض رسالة الموافقة
      if (!approvalNotified) {
        approvalNotified = true;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your account has been approved!"),
            backgroundColor: Colors.green,
          ),
        );
        return; // ⭐ ما ننتقل لسه
      }

      // ⭐ ثاني مرة: ننتقل للّوغ إن
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      // ⭐ إذا ما وافق الأدمن
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your account is still under review"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

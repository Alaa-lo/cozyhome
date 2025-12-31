import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_provider.dart';
import '../screens/login.dart';

class PendingApprovalController {
  bool approvalNotified = false;

  Future<void> checkStatus(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Refresh profile from server
    await authProvider.fetchProfile();

    bool approved = authProvider.user?.isApproved ?? false;

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

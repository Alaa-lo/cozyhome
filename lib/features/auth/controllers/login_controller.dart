import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'package:cozy_home_1/features/renter/screens/homepage.dart';
import 'package:cozy_home_1/features/owner/screens/owner_home_screen.dart';
import 'package:cozy_home_1/features/auth/screens/pendingapprovalscreen.dart';
import 'package:cozy_home_1/features/auth/screens/personalinfoscreen.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    // Call real login
    bool success = await authProvider.login(
      emailController.text,
      passwordController.text,
    );

    if (success) {
      final user = authProvider.user;
      if (user == null) return;

      // Handle profile completion and approval
      // Note: Assuming logic based on API response fields
      if (!user.isApproved && user.role != 'admin') {
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PendingApprovalScreen()),
        );
        return;
      }

      if (user.role == "owner") {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage ?? "Login Failed")),
      );
    }
  }
}

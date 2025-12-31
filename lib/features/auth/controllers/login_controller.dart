import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'package:cozy_home_1/features/renter/screens/homepage.dart';
import 'package:cozy_home_1/features/owner/screens/owner_home_screen.dart';
import 'package:cozy_home_1/features/auth/screens/pendingapprovalscreen.dart';
import 'package:cozy_home_1/features/auth/screens/personalinfoscreen.dart';
import 'package:cozy_home_1/admin/admin_dashboard.dart';

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
      // AuthWrapper will automatically navigate based on the new state
      debugPrint("LOGIN SUCCESS: AuthProvider state updated.");
    } else {
      // Only show error snackbar if still mounted
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? "Login Failed")),
        );
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class AdminLoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    // Call real login (same endpoint as normal login)
    bool success = await authProvider.login(
      emailController.text,
      passwordController.text,
    );

    if (success) {
      // Check if user is admin
      if (authProvider.user?.role.toLowerCase() == "admin") {
        // AuthWrapper will automatically navigate to AdminDashboard
        debugPrint("ADMIN LOGIN SUCCESS: AuthProvider state updated.");
      } else {
        // User is not admin
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Access denied. Admin credentials required."),
            ),
          );
          await authProvider.logout();
        }
      }
    } else {
      // Only show error snackbar if still mounted
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? "Login Failed")),
        );
      }
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

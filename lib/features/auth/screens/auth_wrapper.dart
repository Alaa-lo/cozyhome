import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_provider.dart';
import 'login.dart';
import 'pendingapprovalscreen.dart';
import '../../owner/screens/owner_home_screen.dart';
import '../../renter/screens/homepage.dart';
import '../../../admin/admin_dashboard.dart';
import '../../splash/screens/splashscreen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _showLogin = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        print("AuthWrapper: isAuthenticated=${authProvider.isAuthenticated}, isLoading=${authProvider.isLoading}, showLogin=$_showLogin, user=${authProvider.user?.fullname}, role=${authProvider.user?.role}");

        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: Color(0xFF234E36))),
          );
        }

        if (!authProvider.isAuthenticated) {
          if (_showLogin) {
            return LoginScreen();
          } else {
            return SplashScreen(
              onStart: () {
                setState(() {
                  _showLogin = true;
                });
              },
            );
          }
        }

        final user = authProvider.user;
        if (user == null) {
          return LoginScreen();
        }

        // Handle Admin
        if (user.role.toLowerCase() == "admin") {
          return const AdminDashboard();
        }

        // Handle Pending Approval
        if (!user.isApproved) {
          return const PendingApprovalScreen();
        }

        // Handle Roles
        if (user.role.toLowerCase() == "owner") {
          return const OwnerHomeScreen();
        } else {
          return const RenterHomeScreen();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cozy_home_1/admin/admin_login.dart';
import 'package:cozy_home_1/admin/admin_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const AdminLoginScreen(),

      routes: {
        '/admin_login': (context) => const AdminLoginScreen(),
        '/admin_dashboard': (context) => const AdminDashboard(),
      },
    );
  }
}

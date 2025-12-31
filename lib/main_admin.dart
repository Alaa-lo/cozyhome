import 'package:cozy_home_1/features/auth/screens/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cozy_home_1/features/auth/controllers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const AdminLoginScreen(),

      routes: {'/admin_login': (context) => AdminLoginScreen()},
    );
  }
}

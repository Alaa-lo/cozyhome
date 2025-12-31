import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin/admin_dashboard.dart';
import 'package:cozy_home_1/features/auth/controllers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AdminDashboard(),
      ),
    ),
  );
}

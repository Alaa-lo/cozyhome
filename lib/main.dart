import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cozy_home_1/features/auth/controllers/auth_provider.dart';
import 'package:cozy_home_1/features/auth/screens/auth_wrapper.dart';
import 'package:cozy_home_1/features/auth/screens/login.dart';
import 'package:cozy_home_1/features/auth/screens/personalinfoscreen.dart';
import 'package:cozy_home_1/features/auth/controllers/pendingapprovalcontroller.dart';

import 'package:cozy_home_1/features/renter/controllers/FilterController.dart';
import 'package:cozy_home_1/features/renter/controllers/bookingcontroller.dart';
import 'package:cozy_home_1/features/renter/controllers/bookinglistcontroller.dart';
import 'package:cozy_home_1/features/renter/controllers/rating_controller.dart';
import 'package:cozy_home_1/features/renter/controllers/homepage_controller.dart';

import 'package:cozy_home_1/features/owner/controllers/owner_home_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FilterController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
        ChangeNotifierProvider(create: (_) => BookingListController()),
        ChangeNotifierProvider(create: (_) => RatingController()),
        ChangeNotifierProvider(create: (_) => RenterHomeController()),
        ChangeNotifierProvider(create: (_) => OwnerHomeController()),
        ChangeNotifierProvider(
          create: (_) => PendingApprovalController(),
        ), // ✅ أضفناه هنا
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/personalInfo': (context) => const PersonalInfoScreen(),
        // ممكن تضيف route للـ PendingApprovalScreen إذا بدك تستدعيه بالاسم
        // '/pendingApproval': (context) => const PendingApprovalScreen(),
      },
    );
  }
}

import 'package:cozy_home_1/features/renter/controllers/FilterController.dart';
import 'package:cozy_home_1/features/renter/controllers/bookingcontroller.dart';
import 'package:cozy_home_1/features/renter/controllers/bookinglistcontroller.dart';
import 'package:cozy_home_1/features/renter/controllers/favorites_controller.dart';
import 'package:cozy_home_1/features/renter/controllers/rating_controller.dart';
import 'package:cozy_home_1/features/splash/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cozy_home_1/features/auth/screens/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
        ChangeNotifierProvider(create: (_) => BookingListController()),
        ChangeNotifierProvider(create: (_) => RatingController()),
        ChangeNotifierProvider(create: (_) => BookingListController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
      ],
      child: const MyApp(),
      //ggggggggggggggggggggggg
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {'/login': (context) => LoginScreen()},
    );
  }
}

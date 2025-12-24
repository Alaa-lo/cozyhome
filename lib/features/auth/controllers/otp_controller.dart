import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/auth/screens/accountcreatedscreen.dart';

class OTPController {
  // 6 خانات OTP
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // مؤقتًا كود ثابت
  final String fakeOTP = "123456";

  void verifyOTP(BuildContext context) {
    String enteredOTP = otpControllers.map((c) => c.text).join();

    if (enteredOTP.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all 6 digits")),
      );
      return;
    }

    if (enteredOTP == fakeOTP) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountCreatedScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect code, please try again")),
      );
    }
  }
}

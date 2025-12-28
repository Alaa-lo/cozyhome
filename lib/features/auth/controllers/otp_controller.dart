import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/auth/screens/pendingapprovalscreen.dart';

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
      // ⭐ بعد التحقق → ننتقل إلى شاشة انتظار موافقة الأدمن
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PendingApprovalScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect code, please try again")),
      );
    }
  }
}

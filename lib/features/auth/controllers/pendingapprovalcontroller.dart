import 'package:flutter/material.dart';
import '../screens/login.dart';

class PendingApprovalController extends ChangeNotifier {
  bool isLoading = false;

  Future<void> checkStatus(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // عرض رسالة الموافقة مباشرة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your account is approved. Redirecting..."),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // انتظار بسيط قبل الانتقال
      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

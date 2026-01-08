import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/pendingapprovalcontroller.dart';

class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PendingApprovalController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline, // بدل الساعة بعلامة صح
                size: 90,
                color: Color(0xFF234E36),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your Account is Approved",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234E36),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "You can now log in to your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF234E36),
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: controller.isLoading
                    ? null
                    : () async {
                        await controller.checkStatus(context);
                      },
                child: controller.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Go to Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Press the button to continue.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

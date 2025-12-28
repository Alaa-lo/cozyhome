import 'package:flutter/material.dart';
import '../controllers/pendingapprovalcontroller.dart';

class PendingApprovalScreen extends StatefulWidget {
  const PendingApprovalScreen({super.key});

  @override
  State<PendingApprovalScreen> createState() => _PendingApprovalScreenState();
}

class _PendingApprovalScreenState extends State<PendingApprovalScreen> {
  final PendingApprovalController controller = PendingApprovalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_top_rounded,
                size: 90,
                color: Color(0xFF234E36),
              ),

              const SizedBox(height: 20),

              const Text(
                "Your Account is Under Review",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234E36),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Please wait until the admin approves your account.\nYou will be able to log in once approved.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF234E36),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  await controller.checkStatus(context);
                  setState(() {}); // ⭐ حتى يظهر النص بعد الموافقة
                },
                child: const Text(
                  "Check Status",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              // ⭐ يظهر فقط بعد الموافقة
              if (controller.approvalNotified)
                const Text(
                  "Your account is approved! Press again to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF234E36),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              const SizedBox(height: 20),

              const Text(
                "This may take a few minutes.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

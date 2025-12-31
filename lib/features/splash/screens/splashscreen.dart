import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onStart;

  const SplashScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/logos/cozyhomelogo.png',
                          width: 400,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "The feeling of cozy in every step...",
                    style: TextStyle(fontSize: 16, color: Color(0xFF375534)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 60),

          Padding(
            padding: const EdgeInsets.all(100.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF234E36),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              // ✅ التعديل الوحيد هون
              onPressed: onStart,

              child: const Text(
                "Start Your Journey",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/screens/homepage.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

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
              // ✅ Title
              const Text(
                "Thank You!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234E36),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Texts inside a styled box with heart icons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F4E6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF234E36), width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F4E6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF234E36),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Color(0xFF234E36),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Your information has been successfully submitted.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF375534),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F4E6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF234E36),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Color(0xFF234E36),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Your details are now under review. Once approved by the admin, you will be able to continue browsing the app.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF234E36),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // ✅ Back button
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Finish button → Go to Home
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBEADA),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Color(0xFF234E36), width: 2),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RenterHomeScreen()),
                  );
                },
                child: const Text(
                  "Finish",
                  style: TextStyle(
                    color: Color(0xFF234E36),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

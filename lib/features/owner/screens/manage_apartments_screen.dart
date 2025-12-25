import 'package:flutter/material.dart';

class ManageApartmentsScreen extends StatelessWidget {
  const ManageApartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        title: const Text(
          "Manage Apartments",
          style: TextStyle(color: Color(0xFFEBEADA)),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_work_outlined, size: 80, color: Color(0xFF234E36)),
            SizedBox(height: 20),
            Text(
              "Manage Apartments Screen",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF234E36),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Coming soon...",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

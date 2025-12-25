import 'package:flutter/material.dart';

class BookingRequestsScreen extends StatelessWidget {
  const BookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        title: const Text(
          "Booking Requests",
          style: TextStyle(color: Color(0xFFEBEADA)),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt, size: 80, color: Color(0xFF234E36)),
            SizedBox(height: 20),
            Text(
              "Booking Requests Screen",
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

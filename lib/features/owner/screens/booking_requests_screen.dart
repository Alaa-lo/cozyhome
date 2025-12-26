import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [_bookingCard()],
      ),
    );
  }

  Widget _bookingCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // التاريخ
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Color(0xFF234E36)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "12/2/2025  →  15/2/2025",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF234E36),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // عدد الضيوف
          Row(
            children: [
              const Icon(Icons.group, color: Color(0xFF234E36)),
              const SizedBox(width: 10),
              Text("3 Guest(s)", style: GoogleFonts.poppins(fontSize: 16)),
            ],
          ),

          const SizedBox(height: 12),

          // ملاحظات
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.note, color: Color(0xFF234E36)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Please prepare the apartment before arrival.",
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // أزرار قبول / رفض
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF234E36), width: 2),
                ),
                child: const Text(
                  "Reject",
                  style: TextStyle(color: Color(0xFF234E36)),
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF234E36),
                ),
                child: const Text(
                  "Accept",
                  style: TextStyle(color: Color(0xFFEBEADA)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

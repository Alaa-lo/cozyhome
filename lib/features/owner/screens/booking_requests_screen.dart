import 'package:cozy_home_1/features/owner/controllers/owner_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/models/booking_model.dart';

class BookingRequestsScreen extends StatelessWidget {
  const BookingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OwnerBookingController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFEBEADA),
          appBar: AppBar(
            backgroundColor: const Color(0xFF234E36),
            title: const Text(
              "Booking Requests",
              style: TextStyle(color: Color(0xFFEBEADA)),
            ),
          ),

          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.bookings.isEmpty
              ? const Center(
                  child: Text(
                    "No booking requests found",
                    style: TextStyle(color: Color(0xFF234E36), fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.bookings.length,
                  itemBuilder: (context, index) {
                    return _bookingCard(controller.bookings[index], controller);
                  },
                ),
        );
      },
    );
  }

  Widget _bookingCard(Booking booking, OwnerBookingController controller) {
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
                  "${booking.startDate}  →  ${booking.endDate}",
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
              Text(
                "${booking.numberOfPersons} Guest(s)",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
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
                  booking.notes ?? "No notes",
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
                onPressed: () => controller.reject(booking.id),
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
                onPressed: () => controller.approve(booking.id),
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

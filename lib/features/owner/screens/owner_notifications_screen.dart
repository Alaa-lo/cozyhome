import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerNotificationsScreen extends StatelessWidget {
  const OwnerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        elevation: 0,
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _notificationItem(
            icon: Icons.person_add_alt_1,
            title: "New booking request",
            message: "A renter has requested to book your apartment.",
            time: "Just now",
          ),
          _divider(),

          _notificationItem(
            icon: Icons.edit_calendar,
            title: "Booking updated",
            message: "A renter has modified their booking dates.",
            time: "1 hour ago",
          ),
          _divider(),

          _notificationItem(
            icon: Icons.cancel,
            title: "Booking cancelled",
            message: "A renter has cancelled their booking.",
            time: "Yesterday",
          ),
          _divider(),

          _notificationItem(
            icon: Icons.star_rate_rounded,
            title: "New rating received",
            message: "A renter left a new rating on your apartment.",
            time: "3 days ago",
          ),
        ],
      ),
    );
  }

  Widget _notificationItem({
    required IconData icon,
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF234E36).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF234E36), size: 22),
          ),

          const SizedBox(width: 12),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF234E36),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 1,
      color: Colors.black.withOpacity(0.1),
    );
  }
}

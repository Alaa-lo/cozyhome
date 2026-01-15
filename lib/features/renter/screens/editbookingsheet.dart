import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cozy_home_1/core/models/booking_model.dart';
import 'package:cozy_home_1/features/renter/service/booking_service.dart';

class EditBookingSheet extends StatefulWidget {
  final Booking booking;

  const EditBookingSheet({super.key, required this.booking});

  @override
  State<EditBookingSheet> createState() => _EditBookingSheetState();
}

class _EditBookingSheetState extends State<EditBookingSheet> {
  late DateTime checkIn;
  late DateTime checkOut;

  @override
  void initState() {
    super.initState();
    checkIn = widget.booking.startDate;
    checkOut = widget.booking.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFEBEADA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Edit Booking",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF234E36),
            ),
          ),

          const SizedBox(height: 25),

          _datePickerTile(
            title: "Check-in Date",
            date: checkIn,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: checkIn,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() => checkIn = picked);
              }
            },
          ),

          const SizedBox(height: 15),

          _datePickerTile(
            title: "Check-out Date",
            date: checkOut,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: checkOut,
                firstDate: checkIn,
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() => checkOut = picked);
              }
            },
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF234E36),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () async {
              final service = BookingService();

              try {
                final updatedBooking = await service.updateBooking(
                  bookingId: widget.booking.id,
                  startDate: checkIn.toIso8601String(),
                  endDate: checkOut.toIso8601String(),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Booking updated successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context, updatedBooking);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              "Save Changes",
              style: TextStyle(
                color: Color(0xFFEBEADA),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _datePickerTile({
    required String title,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F5E8),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: Color(0xFF234E36)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$title: ${date.day}/${date.month}/${date.year}",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF234E36),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

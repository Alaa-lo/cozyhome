import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cozy_home_1/features/renter/controllers/bookingcontroller.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        title: const Text(
          "Booking Request",
          style: TextStyle(color: Color(0xFFEBEADA)),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Select Dates"),
            _sectionSubtitle("Choose when you want to stay"),

            _card(
              child: Column(
                children: [
                  _datePicker(
                    context,
                    label: "Check-in Date",
                    value: controller.checkIn,
                    onTap: () async {
                      final date = await _pickDate(context);
                      if (date != null) controller.setCheckIn(date);
                    },
                  ),
                  const SizedBox(height: 15),
                  _datePicker(
                    context,
                    label: "Check-out Date",
                    value: controller.checkOut,
                    onTap: () async {
                      final date = await _pickDate(context);
                      if (date != null) controller.setCheckOut(date);
                    },
                  ),
                ],
              ),
            ),

            // ✅ رسالة الخطأ
            if (controller.dateErrorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  controller.dateErrorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const SizedBox(height: 25),

            _sectionTitle("Guests"),
            _sectionSubtitle("How many people will stay?"),

            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${controller.guests} Guest(s)",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xFF234E36),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      _circleBtn(
                        icon: Icons.remove,
                        onTap: () {
                          if (controller.guests > 1) {
                            controller.setGuests(controller.guests - 1);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      _circleBtn(
                        icon: Icons.add,
                        onTap: () {
                          controller.setGuests(controller.guests + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _sectionTitle("Notes (Optional)"),
            _sectionSubtitle("Add any extra details for the owner"),

            _card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.edit, color: Color(0xFF234E36)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      maxLines: 4,
                      onChanged: controller.setNotes,
                      decoration: const InputDecoration(
                        hintText: "Write any notes for the owner...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ✅ زر إرسال الطلب
            SizedBox(
              width: double.infinity,
              child: AnimatedScale(
                scale: controller.isValid ? 1 : 0.97,
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF234E36),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.isValid
                      ? () {
                          final data = controller.getBookingData();
                          Navigator.pop(context, data);
                        }
                      : null,
                  child: Text(
                    "Send Booking Request",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xFFEBEADA),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Widgets

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF234E36),
      ),
    );
  }

  Widget _sectionSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _datePicker(
    BuildContext context, {
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F6F0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF234E36), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Color(0xFF234E36)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value == null
                    ? label
                    : "${value.day}/${value.month}/${value.year}",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: value == null
                      ? Colors.black54
                      : const Color(0xFF234E36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF234E36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFFEBEADA), size: 20),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF234E36)),
          ),
          child: child!,
        );
      },
    );
  }
}

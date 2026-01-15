import 'package:cozy_home_1/core/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/rating_controller.dart';

class RatingScreen extends StatelessWidget {
  final Booking booking;

  const RatingScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RatingController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        title: Text(
          "Rate Your Stay",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Text(
              "How was your experience?",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF234E36),
              ),
            ),

            const SizedBox(height: 30),

            // ⭐⭐⭐⭐⭐ نجوم التقييم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < controller.rating ? Icons.star : Icons.star_border,
                    color: const Color(0xFF234E36),
                    size: 40,
                  ),
                  onPressed: () {
                    controller.setRating(index + 1.0);
                  },
                );
              }),
            ),

            const SizedBox(height: 40),

            // زر الإرسال
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF234E36),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final success = await controller.submitRating(booking);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Thank you for your rating!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed to submit rating"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/rating_controller.dart';

class RatingScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

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
                  await controller.submitRating(booking);
                  Navigator.pop(context);
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

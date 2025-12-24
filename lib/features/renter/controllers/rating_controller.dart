import 'package:flutter/material.dart';

class RatingController extends ChangeNotifier {
  double rating = 0;

  void setRating(double value) {
    rating = value;
    notifyListeners();
  }

  Future<void> submitRating(Map<String, dynamic> booking) async {
    // هون بتحطي كود حفظ التقييم بالفايربيس أو الداتابيس
    // مثال:
    // await FirebaseFirestore.instance.collection("ratings").add({
    //   "bookingId": booking["id"],
    //   "rating": rating,
    //   "timestamp": DateTime.now(),
    // });

    print("Rating submitted: $rating");
  }
}

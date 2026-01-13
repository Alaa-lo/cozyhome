import 'package:flutter/material.dart';
import 'package:cozy_home_1/core/models/booking_model.dart';
import 'package:cozy_home_1/features/renter/service/booking_service.dart';

class RatingController extends ChangeNotifier {
  final BookingService _bookingService = BookingService();
  double rating = 0;

  void setRating(double value) {
    rating = value;
    notifyListeners();
  }

  Future<void> submitRating(Booking booking, {String? comment}) async {
    final success = await _bookingService.submitReview(
      booking.id,
      rating: rating.toInt(),
      comment: comment,
    );

    if (success) {
      print("Rating submitted: $rating");
    }
  }
}

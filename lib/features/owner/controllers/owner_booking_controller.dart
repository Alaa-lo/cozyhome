import 'package:cozy_home_1/core/models/booking_model.dart';
import 'package:cozy_home_1/features/owner/service/owner_apartment_service.dart';
import 'package:flutter/material.dart';

class OwnerBookingController extends ChangeNotifier {
  final OwnerApartmentService _service = OwnerApartmentService();

  List<Booking> bookings = [];
  bool isLoading = false;

  Future<void> loadBookings() async {
    isLoading = true;
    notifyListeners();

    bookings = await _service.getOwnerBookings();

    isLoading = false;
    notifyListeners();
  }

  Future<void> approve(int id) async {
    final success = await _service.approveBooking(id);
    if (success) {
      bookings.removeWhere((b) => b.id == id);
      notifyListeners();
    }
  }

  Future<void> reject(int id) async {
    final success = await _service.rejectBooking(id);
    if (success) {
      bookings.removeWhere((b) => b.id == id);
      notifyListeners();
    }
  }
}

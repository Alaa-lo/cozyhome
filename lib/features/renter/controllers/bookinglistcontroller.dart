import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/models/booking.dart';
import 'package:cozy_home_1/features/renter/service/booking_service.dart';

class BookingListController extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  List<Booking> currentBookings = [];
  List<Booking> previousBookings = [];
  List<Booking> cancelledBookings = [];
  bool isLoading = false;

  Future<void> fetchBookings() async {
    isLoading = true;
    notifyListeners();

    final allBookings = await _bookingService.getMyBookings();

    currentBookings = allBookings
        .where((b) => b.status == 'approved' || b.status == 'pending')
        .toList();
    previousBookings = allBookings
        .where((b) => b.status == 'completed')
        .toList();
    cancelledBookings = allBookings
        .where((b) => b.status == 'cancelled' || b.status == 'rejected')
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> cancelBooking(int bookingId) async {
    final success = await _bookingService.cancelBooking(bookingId);
    if (success) {
      await fetchBookings();
    }
  }

  Future<void> addBooking(Map<String, dynamic> data) async {
    try {
      final apartment = data['apartment'];
      final apartmentId = apartment?.id ?? 0;

      await _bookingService.createBooking(
        apartmentId: apartmentId,
        startDate: (data['checkIn'] as DateTime).toIso8601String(),
        endDate: (data['checkOut'] as DateTime).toIso8601String(),
        numberOfPersons: data['guests'] ?? 1,
        notes: data['notes'],
      );
      await fetchBookings();
    } catch (e) {
      debugPrint("Error creating booking: $e");
    }
  }

  Future<void> moveToPrevious(Booking booking) async {
    // In a real API, this might be handled by the server when a booking's dates pass.
    // For now, we can just refresh.
    await fetchBookings();
  }

  Future<void> updateBooking(
    Booking oldBooking,
    Map<String, dynamic> newData,
  ) async {
    // Implement update via service if available in backend
    // For now, we refresh to get latest state from server
    await fetchBookings();
  }
}

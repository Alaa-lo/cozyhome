import 'package:flutter/material.dart';
import 'package:cozy_home_1/core/models/booking_model.dart';
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
    final today = DateTime.now();

    // 🔹 Cancelled
    cancelledBookings = allBookings
        .where((b) => b.status == 'cancelled' || b.status == 'rejected')
        .toList();

    // 🔹 Previous (انتهى)
    previousBookings = allBookings.where((b) {
      return b.endDate.isBefore(today) &&
          b.status != 'cancelled' &&
          b.status != 'rejected';
    }).toList();

    // 🔹 Current (ضمن المدة)
    currentBookings = allBookings.where((b) {
      return b.startDate.isBefore(today) &&
          b.endDate.isAfter(today) &&
          b.status != 'cancelled' &&
          b.status != 'rejected';
    }).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> cancelBooking(int bookingId) async {
    final success = await _bookingService.cancelBooking(bookingId);
    if (success) {
      await fetchBookings();
    }
  }

  Future<void> addBooking({
    required int apartmentId,
    required DateTime startDate,
    required DateTime endDate,
    required int guests,
    String? notes,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _bookingService.createBooking(
        apartmentId: apartmentId,
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String(),
        numberOfPersons: guests,
        notes: notes,
      );

      await fetchBookings();
    } catch (e) {
      debugPrint("❌ Create Booking Error: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> moveToPrevious(Booking booking) async {
    await fetchBookings();
  }

  Future<void> updateBooking(
    Booking oldBooking,
    Map<String, dynamic> newData,
  ) async {
    await fetchBookings();
  }
}

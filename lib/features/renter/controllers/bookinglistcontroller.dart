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

  // في BookingListController
  Future<void> addBooking({
    required int apartmentId, // مرر الرقم مباشرة
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

      await fetchBookings(); // تحديث القائمة بعد النجاح
    } catch (e) {
      debugPrint("❌ Create Booking Error: $e");
      rethrow; // مهم جداً لكي يشعر الـ UI بالخطأ
    } finally {
      isLoading = false;
      notifyListeners();
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

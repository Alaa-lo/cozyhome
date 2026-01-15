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

    try {
      final allBookings = await _bookingService.getMyBookings();

      // توحيد النصوص للمقارنة
      String getStatus(Booking b) => b.status.toLowerCase();

      // 1. المكنسلة أو المرفوضة
      cancelledBookings = allBookings
          .where(
            (b) => getStatus(b) == 'cancelled' || getStatus(b) == 'rejected',
          )
          .toList();

      // 2. السابقة (التي انتهت بالفعل - حالتها مكتملة)
      previousBookings = allBookings
          .where(
            (b) => getStatus(b) == 'completed' || getStatus(b) == 'previous',
          )
          .toList();

      // 3. الحالية (أي حجز حالته مقبول أو حالي أو بانتظار الموافقة ولم يُلغى)
      currentBookings = allBookings.where((b) {
        final status = getStatus(b);
        // نعتبر الحجز حالي إذا كان مقبولاً (approved) أو قيد الانتظار (pending)
        // أو إذا كان الباك أند وضعه في قائمة current
        return status == 'approved' ||
            status == 'pending' ||
            status == 'current';
      }).toList();
    } catch (e) {
      debugPrint("❌ Filter Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
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

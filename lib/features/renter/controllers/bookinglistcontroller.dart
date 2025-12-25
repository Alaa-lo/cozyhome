import 'package:flutter/material.dart';

class BookingListController extends ChangeNotifier {
  List<Map<String, dynamic>> currentBookings = [];
  List<Map<String, dynamic>> previousBookings = [];
  List<Map<String, dynamic>> cancelledBookings = [];

  // ⭐ إضافة حجز جديد (افتراضياً Current)
  void addBooking(Map<String, dynamic> booking) {
    // ⭐ أهم تعديل: تأكيد وجود apartment
    if (!booking.containsKey("apartment") || booking["apartment"] == null) {
      debugPrint("❌ ERROR: Booking has no 'apartment' assigned!");
      return; // منع الكراش
    }

    booking["status"] = "current";
    currentBookings.add(booking);
    notifyListeners();
  }

  // ⭐ نقل الحجز إلى Previous
  void moveToPrevious(Map<String, dynamic> booking) {
    _removeFromAll(booking);

    previousBookings.add({...booking, "status": "previous"});

    notifyListeners();
  }

  // ⭐ نقل الحجز إلى Cancelled
  void moveToCancelled(Map<String, dynamic> booking) {
    _removeFromAll(booking);

    cancelledBookings.add({...booking, "status": "cancelled"});

    notifyListeners();
  }

  // ⭐ حذف نهائي
  void deleteBooking(Map<String, dynamic> booking) {
    _removeFromAll(booking);
    notifyListeners();
  }

  // ⭐ تحديث الحجز
  void updateBooking(
    Map<String, dynamic> oldBooking,
    Map<String, dynamic> newBooking,
  ) {
    // ⭐ تأكيد وجود apartment
    if (!newBooking.containsKey("apartment") ||
        newBooking["apartment"] == null) {
      debugPrint("❌ ERROR: Updated booking has no 'apartment'!");
      return;
    }

    _removeFromAll(oldBooking);

    newBooking["status"] = "current";
    currentBookings.add(newBooking);

    notifyListeners();
  }

  // ⭐ إزالة من كل القوائم
  void _removeFromAll(Map<String, dynamic> booking) {
    currentBookings.remove(booking);
    previousBookings.remove(booking);
    cancelledBookings.remove(booking);
  }
}

import 'package:flutter/material.dart';

class BookingListController extends ChangeNotifier {
  List<Map<String, dynamic>> currentBookings = [];
  List<Map<String, dynamic>> previousBookings = [];
  List<Map<String, dynamic>> cancelledBookings = [];

  // ✅ إضافة حجز جديد (افتراضياً Current)
  void addBooking(Map<String, dynamic> booking) {
    booking["status"] = "current";
    currentBookings.add(booking);
    notifyListeners();
  }

  // ✅ نقل الحجز إلى Previous (يستخدم عند التعديل)
  void moveToPrevious(Map<String, dynamic> booking) {
    _removeFromAll(booking);

    previousBookings.add({...booking, "status": "previous"});

    notifyListeners();
  }

  // ✅ نقل الحجز إلى Cancelled
  void moveToCancelled(Map<String, dynamic> booking) {
    _removeFromAll(booking);

    cancelledBookings.add({...booking, "status": "cancelled"});

    notifyListeners();
  }

  // ✅ حذف نهائي من جميع القوائم
  void deleteBooking(Map<String, dynamic> booking) {
    _removeFromAll(booking);
    notifyListeners();
  }

  // ✅ تحديث الحجز بعد التعديل (النسخة الجديدة تبقى في Current)
  void updateBooking(
    Map<String, dynamic> oldBooking,
    Map<String, dynamic> newBooking,
  ) {
    _removeFromAll(oldBooking);

    newBooking["status"] = "current";
    currentBookings.add(newBooking);

    notifyListeners();
  }

  // ✅ دالة داخلية تنظف الحجز من كل القوائم قبل نقله
  void _removeFromAll(Map<String, dynamic> booking) {
    currentBookings.remove(booking);
    previousBookings.remove(booking);
    cancelledBookings.remove(booking);
  }
}

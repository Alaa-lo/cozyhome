import 'package:flutter/material.dart';

class BookingController extends ChangeNotifier {
  DateTime? checkIn;
  DateTime? checkOut;
  int guests = 1;
  String notes = "";

  // ✅ تحديد تاريخ الوصول
  void setCheckIn(DateTime date) {
    checkIn = date;
    notifyListeners();
  }

  // ✅ تحديد تاريخ المغادرة
  void setCheckOut(DateTime date) {
    checkOut = date;
    notifyListeners();
  }

  // ✅ عدد الضيوف
  void setGuests(int value) {
    guests = value;
    notifyListeners();
  }

  // ✅ ملاحظات إضافية
  void setNotes(String value) {
    notes = value;
    notifyListeners();
  }

  // ✅ رسالة خطأ تظهر تحت التاريخ
  String? get dateErrorMessage {
    if (checkIn == null || checkOut == null) {
      return "Please select both check-in and check-out dates";
    }
    if (checkOut!.isBefore(checkIn!)) {
      return "Check-out date must be after check-in date";
    }
    return null;
  }

  // ✅ هل البيانات صالحة لإرسال الطلب؟
  bool get isValid {
    return dateErrorMessage == null;
  }

  // ✅ البيانات النهائية للطلب
  Map<String, dynamic> getBookingData() {
    return {
      "checkIn": checkIn,
      "checkOut": checkOut,
      "guests": guests,
      "notes": notes,
    };
  }

  // ✅ إعادة تعيين كل شيء
  void reset() {
    checkIn = null;
    checkOut = null;
    guests = 1;
    notes = "";
    notifyListeners();
  }
}

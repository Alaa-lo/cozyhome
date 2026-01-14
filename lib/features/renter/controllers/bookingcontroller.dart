import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:flutter/material.dart';

class BookingController extends ChangeNotifier {
  DateTime? checkIn;
  DateTime? checkOut;
  int guests = 1;
  String notes = "";

  // جعلناه قابل ليكون null في البداية
  Apartment? selectedApartment;

  // دالة لتحديد الشقة المختارة
  void setApartment(Apartment apt) {
    selectedApartment = apt;
    notifyListeners();
  }

  void setCheckIn(DateTime date) {
    checkIn = date;
    notifyListeners();
  }

  void setCheckOut(DateTime date) {
    checkOut = date;
    notifyListeners();
  }

  void setGuests(int value) {
    guests = value;
    notifyListeners();
  }

  void setNotes(String value) {
    notes = value;
    notifyListeners();
  }

  // رسائل الخطأ الخاصة بالتاريخ
  String? get dateErrorMessage {
    if (checkIn == null || checkOut == null) {
      return "Please select both check-in and check-out dates";
    }
    if (checkOut!.isBefore(checkIn!)) {
      return "Check-out date must be after check-in date";
    }
    return null;
  }

  // التعديل الجوهري: الزر لن يكون فعالاً إلا إذا تم اختيار الشقة والتاريخ معاً
  bool get isValid {
    bool datesValid =
        checkIn != null && checkOut != null && dateErrorMessage == null;
    bool apartmentSelected = selectedApartment != null;

    return datesValid && apartmentSelected;
  }

  // ⭐ تحويل البيانات بشكل آمن للـ API
  Map<String, dynamic> getApiPayload() {
    // نستخدم ?. لضمان عدم حدوث Crash إذا كانت البيانات فارغة لسبب ما
    return {
      "apartment_id": selectedApartment?.id, // سيأخذ الـ ID الخاص بالشقة
      "start_date": checkIn?.toIso8601String().split("T").first,
      "end_date": checkOut?.toIso8601String().split("T").first,
      "number_of_persons": guests,
      "notes": notes.isEmpty ? null : notes,
    };
  }

  // دالة لتنظيف البيانات عند إغلاق الشاشة أو نجاح الحجز
  void reset() {
    checkIn = null;
    checkOut = null;
    guests = 1;
    notes = "";
    selectedApartment = null;
    notifyListeners();
  }
}

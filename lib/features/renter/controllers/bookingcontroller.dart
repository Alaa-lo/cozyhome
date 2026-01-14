import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:flutter/material.dart';

class BookingController extends ChangeNotifier {
  DateTime? checkIn;
  DateTime? checkOut;
  int guests = 1;
  String notes = "";

  Apartment? selectedApartment;

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

  String? get dateErrorMessage {
    if (checkIn == null || checkOut == null) {
      return "Please select both check-in and check-out dates";
    }
    if (checkOut!.isBefore(checkIn!)) {
      return "Check-out date must be after check-in date";
    }
    return null;
  }

  bool get isValid {
    return dateErrorMessage == null && selectedApartment != null;
  }

  // ⭐ البيانات الجاهزة للإرسال للـ API
  Map<String, dynamic> getApiPayload() {
    return {
      "apartment_id": selectedApartment!.id,
      "start_date": checkIn!.toIso8601String().split("T").first,
      "end_date": checkOut!.toIso8601String().split("T").first,
      "number_of_persons": guests,
      "notes": notes.isEmpty ? null : notes,
    };
  }

  void reset() {
    checkIn = null;
    checkOut = null;
    guests = 1;
    notes = "";
    selectedApartment = null;
    notifyListeners();
  }
}

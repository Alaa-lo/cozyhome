import 'package:flutter/material.dart';

class OwnerBookingController extends ChangeNotifier {
  // قائمة طلبات الحجز
  final List<Map<String, dynamic>> requests = [];

  // إضافة طلب جديد
  void addRequest(Map<String, dynamic> booking) {
    requests.add(booking);
    notifyListeners();
  }

  // قبول الطلب
  void acceptRequest(Map<String, dynamic> booking) {
    booking["status"] = "accepted";
    notifyListeners();
  }

  // رفض الطلب
  void rejectRequest(Map<String, dynamic> booking) {
    booking["status"] = "rejected";
    notifyListeners();
  }

  void deleteRequest(Map<String, dynamic> booking) {
    requests.remove(booking);
    notifyListeners();
  }
}

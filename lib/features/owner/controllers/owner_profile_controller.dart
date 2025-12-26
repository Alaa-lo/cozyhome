import 'package:flutter/material.dart';

class OwnerProfileController extends ChangeNotifier {
  String name = "";
  String email = "";
  String phone = "";
  int apartmentsCount = 0;

  bool isLoading = true;

  Future<void> loadUserData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    name = "Owner Name";
    email = "owner@example.com";
    phone = "+963 987 654 321";
    apartmentsCount = 5;

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    print("Owner logged out");
  }
}

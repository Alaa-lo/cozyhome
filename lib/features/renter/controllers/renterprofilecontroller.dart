import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String name = "John Doe";
  String email = "john@example.com";
  String phone = "0790000000";

  bool isLoading = false;

  Future<void> loadUserData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    isLoading = false;
    notifyListeners();
  }

  void updateProfile({String? newName, String? newEmail, String? newPhone}) {
    if (newName != null) name = newName;
    if (newEmail != null) email = newEmail;
    if (newPhone != null) phone = newPhone;

    notifyListeners();
  }

  Future<void> logout() async {
    print("User logged out");
  }
}

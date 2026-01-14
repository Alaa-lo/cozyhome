import 'package:cozy_home_1/features/renter/service/apartment_service.dart';
import 'package:flutter/material.dart';
import '../../../core/models/apartment_model.dart';

class ApartmentDetailsController extends ChangeNotifier {
  final ApartmentService _service = ApartmentService();

  Apartment? apartment;
  bool isLoading = false;
  String? errorMessage;

  // ============================
  // 🔹 Fetch Apartment Details
  // ============================
  Future<void> loadApartment(int id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _service.getApartmentDetails(id);

    if (result != null) {
      apartment = result;
    } else {
      errorMessage = "Failed to load apartment details";
    }

    isLoading = false;
    notifyListeners();
  }
}

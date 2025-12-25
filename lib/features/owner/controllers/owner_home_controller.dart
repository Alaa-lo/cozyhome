import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/owner/models/apartment_model.dart';

class OwnerHomeController extends ChangeNotifier {
  // -------------------------------
  // Navigation + Animation
  // -------------------------------
  late AnimationController navController;
  late Animation<double> curveAnimation;

  int selectedIndex = 0;

  void initAnimations(TickerProvider vsync) {
    navController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    curveAnimation = CurvedAnimation(
      parent: navController,
      curve: Curves.easeOut,
    );
  }

  void onNavTapped(int index, VoidCallback onComplete) {
    selectedIndex = index;
    navController.forward(from: 0).then((_) => onComplete());
    notifyListeners();
  }

  @override
  void dispose() {
    navController.dispose();
    super.dispose();
  }

  // -------------------------------
  // Apartments Data
  // -------------------------------
  final List<ApartmentModel> apartments = [];

  void addApartment(ApartmentModel apt) {
    apartments.add(apt);
    notifyListeners();
  }

  void deleteApartment(int index) {
    apartments.removeAt(index);
    notifyListeners();
  }

  void updateApartment(int index, ApartmentModel updated) {
    apartments[index] = updated;
    notifyListeners();
  }
}

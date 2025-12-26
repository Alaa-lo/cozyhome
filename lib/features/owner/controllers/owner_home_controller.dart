import 'package:flutter/material.dart';
import '../models/apartment_model.dart';

class OwnerHomeController extends ChangeNotifier {
  late AnimationController navController;
  late Animation<double> curveAnimation;

  int selectedIndex = 0;

  final List<ApartmentModel> apartments = [];

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

  void addApartment(ApartmentModel apt) {
    apartments.add(apt);
    notifyListeners();
  }

  void deleteApartment(String id) {
    apartments.removeWhere((apt) => apt.id == id);
    notifyListeners();
  }

  void updateApartment(ApartmentModel updated) {
    final i = apartments.indexWhere((apt) => apt.id == updated.id);
    if (i != -1) {
      apartments[i] = updated;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    navController.dispose();
    super.dispose();
  }
}

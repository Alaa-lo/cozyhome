import 'package:flutter/material.dart';
import '../models/apartment_model.dart';

class OwnerHomeController extends ChangeNotifier {
  late AnimationController animationController;
  late Animation<double> curveAnimation;

  int selectedIndex = 0;

  List<ApartmentModel> apartments = [];

  void initAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    curveAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    animationController.forward();
  }

  void addApartment(ApartmentModel apt) {
    apartments.add(apt);
    notifyListeners();
  }

  void updateApartment(int index, ApartmentModel updatedApt) {
    apartments[index] = updatedApt;
    notifyListeners();
  }

  void deleteApartment(int index) {
    apartments.removeAt(index);
    notifyListeners();
  }

  void onNavTapped(int index, VoidCallback onCompleted) {
    if (index == selectedIndex) return;

    selectedIndex = index;
    animationController.forward(from: 0).whenComplete(onCompleted);
    notifyListeners();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

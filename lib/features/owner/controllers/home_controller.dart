import 'package:flutter/material.dart';

class OwnerHomeController extends ChangeNotifier {
  late AnimationController animationController;
  late Animation<double> curveAnimation;

  int selectedIndex = 0;

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

  void onNavTapped(int index, VoidCallback onCompleted) {
    if (index == selectedIndex) return;

    selectedIndex = index;
    animationController.forward(from: 0).whenComplete(onCompleted);
    notifyListeners();
  }

  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

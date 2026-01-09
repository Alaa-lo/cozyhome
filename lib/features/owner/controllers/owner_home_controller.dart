import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/models/apartment.dart';
import 'package:cozy_home_1/features/owner/service/owner_apartment_service.dart';

class OwnerHomeController extends ChangeNotifier {
  final OwnerApartmentService _service = OwnerApartmentService();

  List<Apartment> apartments = [];

  late AnimationController animationController;
  late Animation<double> curveAnimation;

  int selectedIndex = 0;

  // ---------------- INIT ANIMATIONS ----------------
  void initAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );

    curveAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    animationController.forward();
  }

  // ---------------- FETCH APARTMENTS ----------------
  Future<void> fetchApartments() async {
    try {
      final data = await _service.getMyApartments();
      apartments = data;
      notifyListeners();
    } catch (e) {
      print("Error fetching apartments: $e");
    }
  }

  // ---------------- ADD APARTMENT ----------------
  void addApartment(Apartment apartment) {
    apartments.insert(0, apartment); // إضافة الشقة في أول القائمة
    notifyListeners();
  }

  // ---------------- UPDATE APARTMENT ----------------
  Future<void> updateApartment(Apartment updated) async {
    try {
      final newApt = await _service.updateApartment(updated);

      final index = apartments.indexWhere((a) => a.id == updated.id);
      if (index != -1) {
        apartments[index] = newApt;
        notifyListeners();
      }
    } catch (e) {
      print("Update error: $e");
    }
  }

  // ---------------- DELETE APARTMENT ----------------
  Future<void> deleteApartment(int id) async {
    final success = await _service.deleteApartment(id);

    if (success) {
      apartments.removeWhere((apt) => apt.id == id);
      notifyListeners();
    }
  }

  // ---------------- NAVIGATION HANDLER ----------------
  void onNavTapped(int index, VoidCallback onPageChanged) {
    selectedIndex = index;

    animationController.reset();
    animationController.forward();

    onPageChanged();
    notifyListeners();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

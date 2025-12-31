import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/models/apartment.dart';
import 'package:cozy_home_1/features/owner/service/owner_apartment_service.dart';

class OwnerHomeController extends ChangeNotifier {
  final OwnerApartmentService _ownerService = OwnerApartmentService();
  
  late AnimationController navController;
  late Animation<double> curveAnimation;

  int selectedIndex = 0;

  List<Apartment> apartments = [];
  bool isLoading = false;

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

  Future<void> fetchApartments() async {
    isLoading = true;
    notifyListeners();
    try {
      apartments = await _ownerService.getMyApartments();
    } catch (e) {
      debugPrint("Error fetching owner apartments: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  void addApartment(Apartment apt) {
    apartments.add(apt);
    notifyListeners();
  }

  void deleteApartment(int id) {
    apartments.removeWhere((apt) => apt.id == id);
    notifyListeners();
  }

  void updateApartment(Apartment updated) {
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

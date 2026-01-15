import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/service/apartment_service.dart';

class RenterHomeController extends ChangeNotifier {
  final ApartmentService _apartmentService = ApartmentService();

  // ============================
  // 🔹 Animation
  // ============================
  late AnimationController navController;
  late Animation<double> curveAnimation;
  int selectedIndex = 0;

  // ============================
  // 🔹 Apartments List
  // ============================
  List<Apartment> apartments = [];
  List<Apartment> filtered = [];
  bool isLoading = false;

  // ============================
  // 🔹 Fetch apartments (initial load)
  // ============================
  Future<void> fetchApartments() async {
    isLoading = true;
    notifyListeners();

    final result = await _apartmentService.getApartments();

    apartments = result;
    filtered = List.from(apartments);

    isLoading = false;
    notifyListeners();
  }

  // ============================
  // 🔹 Apply filters (API-based)
  // ============================
  Future<void> applyFilters(Map<String, dynamic> filters) async {
    isLoading = true;
    notifyListeners();

    final result = await _apartmentService.getApartments(
      city: filters["city"],
      province: filters["province"],
      minPrice: filters["minPrice"],
      maxPrice: filters["maxPrice"],
    );

    filtered = result.toList();

    isLoading = false;
    notifyListeners();
  }

  // ============================
  // ⭐ Favorites list
  // ============================
  List<Apartment> favorites = [];

  void toggleFavorite(Apartment apt) {
    if (favorites.contains(apt)) {
      favorites.remove(apt);
    } else {
      favorites.add(apt);
    }
    notifyListeners();
  }

  bool isFavorite(Apartment apt) {
    return favorites.contains(apt);
  }

  // ============================
  // 🔹 Initialize
  // ============================
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

  // ============================
  // 🔹 Dispose
  // ============================
  @override
  void dispose() {
    navController.dispose();
    super.dispose();
  }

  // ============================
  // 🔹 Navigation animation
  // ============================
  void onNavTapped(int index, VoidCallback updateUI) {
    selectedIndex = index;
    navController.forward(from: 0);
    updateUI();
  }
}

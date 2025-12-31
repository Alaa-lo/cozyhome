import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/models/apartment.dart';
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
  bool isLoading = false;

  Future<void> fetchApartments() async {
    isLoading = true;
    notifyListeners();
    apartments = await _apartmentService.getApartments();
    filtered = List.from(apartments);
    isLoading = false;
    notifyListeners();
  }

  // ============================
  // 🔹 Filtered list
  // ============================
  List<Apartment> filtered = [];

  // ============================
  // ⭐ Favorites list
  // ============================
  List<Apartment> favorites = [];

  // ⭐ Toggle favorite
  void toggleFavorite(Apartment apt) {
    if (favorites.contains(apt)) {
      favorites.remove(apt);
    } else {
      favorites.add(apt);
    }
    notifyListeners();
  }

  // ⭐ Check if favorite
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

    filtered = List.from(apartments);
  }

  // ============================
  // 🔹 Dispose
  // ============================
  void dispose() {
    super.dispose();
    navController.dispose();
  }

  // ============================
  // 🔹 Navigation animation
  // ============================
  void onNavTapped(int index, VoidCallback updateUI) {
    selectedIndex = index;
    navController.forward(from: 0);
    updateUI();
  }

  // ============================
  // 🔹 Apply filters
  // ============================
  void applyFilters(Map<String, dynamic> filters) {
    String? province = filters["governorate"] ?? filters["province"];
    String? city = filters["city"];
    double minPrice = filters["minPrice"];
    double maxPrice = filters["maxPrice"];

    filtered = apartments.where((apt) {
      bool matchesProvince =
          province == null || apt.province == province;

      bool matchesCity = city == null || apt.city == city;

      bool matchesPrice = apt.pricePerNight >= minPrice && apt.pricePerNight <= maxPrice;

      return matchesProvince && matchesCity && matchesPrice;
    }).toList();

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/models/apartment_model.dart';

class RenterHomeController extends ChangeNotifier {
  // ✅ Animation
  late AnimationController navController;
  late Animation<double> curveAnimation;
  int selectedIndex = 0;

  // ✅ Apartments List (dummy data for now)
  final List<Apartment> apartments = [
    Apartment(
      title: "Modern Apartment",
      governorate: "Damascus",
      city: "Mazzeh",
      price: 450,
      images: [
        "assets/images/appartments/firstappartment.jpg",
        "assets/images/bathrooms/firstbathroom.jpg",
        "assets/images/bedrooms/firstbedroom.jpg",
        "assets/images/kitchens/firstkitchen.jpg",
      ],
    ),
    Apartment(
      title: "Cozy Home",
      governorate: "Aleppo",
      city: "Aziziyeh",
      price: 350,
      images: [
        "assets/images/appartments/secondappartment.jpg",
        "assets/images/bathrooms/secondbathroom.jpg",
        "assets/images/bedrooms/secondbedroom.jpg",
        "assets/images/kitchens/secondkitchen.jpg",
      ],
    ),
    Apartment(
      title: "Luxury Flat",
      governorate: "Latakia",
      city: "Corniche",
      price: 900,
      images: [
        "assets/images/appartments/thirdappartment.jpg",
        "assets/images/bathrooms/thirdbathroom.jpg",
        "assets/images/bedrooms/thirdbedroom.jpg",
        "assets/images/kitchens/thirdkitchen.jpg",
      ],
    ),
    Apartment(
      title: "family flat",
      governorate: "Hama",
      city: "Aziziyeh",
      price: 900,
      images: [
        "assets/images/appartments/fourthappartment.jpg",
        "assets/images/bathrooms/fourthbathroom.jpg",
        "assets/images/bedrooms/fourthbedroom.jpg",
        "assets/images/kitchens/fourthkitchen.jpg",
      ],
    ),
    Apartment(
      title: "big Flat",
      governorate: "Aleppo",
      city: "Alzahraa",
      price: 900,
      images: [
        "assets/images/appartments/fifthappartment.jpg",
        "assets/images/bathrooms/fifthbathroom.jpg",
        "assets/images/bedrooms/fifthbedroom.jpg",
        "assets/images/kitchens/fifthkitchen.jpg",
      ],
    ),
    Apartment(
      title: "warm Flat",
      governorate: "Tartous",
      city: "Alqadmous",
      price: 900,
      images: [
        "assets/images/appartments/sixappartment.jpg",
        "assets/images/bathrooms/sixbathroom.jpg",
        "assets/images/bedrooms/sixbedroom.jpg",
        "assets/images/kitchens/sixkitchen.jpg",
      ],
    ),
  ];

  // ✅ Filtered list
  List<Apartment> filtered = [];

  // ✅ Initialize
  void initAnimations(TickerProvider vsync) {
    navController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    curveAnimation = CurvedAnimation(
      parent: navController,
      curve: Curves.easeOut,
    );

    // ✅ أول ما يفتح الهوم، خلي الفلترة = كل الشقق
    filtered = List.from(apartments);
  }

  // ✅ Dispose
  void dispose() {
    super.dispose();
    navController.dispose();
  }

  // ✅ Navigation animation
  void onNavTapped(int index, VoidCallback updateUI) {
    selectedIndex = index;
    navController.forward(from: 0);
    updateUI();
  }

  // ✅ Apply filters
  void applyFilters(Map<String, dynamic> filters) {
    String? governorate = filters["governorate"];
    String? city = filters["city"];
    double minPrice = filters["minPrice"];
    double maxPrice = filters["maxPrice"];

    filtered = apartments.where((apt) {
      bool matchesGovernorate =
          governorate == null || apt.governorate == governorate;

      bool matchesCity = city == null || apt.city == city;

      bool matchesPrice = apt.price >= minPrice && apt.price <= maxPrice;

      return matchesGovernorate && matchesCity && matchesPrice;
    }).toList();

    notifyListeners(); // ✅ مهم جداً لتحديث UI
  }
}

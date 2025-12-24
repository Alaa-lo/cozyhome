import 'package:flutter/material.dart';

class FilterController extends ChangeNotifier {
  // ✅ Selected filters
  String? selectedGovernorate;
  String? selectedCity;
  double minPrice = 500;
  double maxPrice = 3000;

  // ✅ Governorates list
  final List<String> governorates = [
    "Damascus",
    "Aleppo",
    "Homs",
    "Hama",
    "Latakia",
    "Tartous",
  ];

  // ✅ Cities mapped by governorate
  final Map<String, List<String>> citiesByGovernorate = {
    "Damascus": ["Mazzeh", "Kafr Souseh", "Baramkeh", "Rukn Aldin"],
    "Aleppo": ["Aziziyeh", "Seif Al-Dawla", "New Aleppo", "Alzahraa"],
    "Homs": ["Inshaat", "Ghouta", "Hamra", "Aziziyeh"],
    "Hama": ["Al-Hader", "Al-Sabouniyeh"],
    "Latakia": ["Corniche", "Mashroua", "Slaibeh"],
    "Tartous": ["Al-Arida", "Rimal", "Corniche", "Alqadmous"],
  };

  // ✅ Update governorate
  void setGovernorate(String? value) {
    selectedGovernorate = value;

    // Reset city when governorate changes
    selectedCity = null;

    notifyListeners();
  }

  // ✅ Update city
  void setCity(String? value) {
    selectedCity = value;
    notifyListeners();
  }

  // ✅ Update price
  void setPrice(double start, double end) {
    minPrice = start;
    maxPrice = end;
    notifyListeners();
  }

  // ✅ Reset all filters
  void reset() {
    selectedGovernorate = null;
    selectedCity = null;
    minPrice = 500;
    maxPrice = 3000;
    notifyListeners();
  }

  // ✅ Return filters
  Map<String, dynamic> getFilters() {
    return {
      "governorate": selectedGovernorate,
      "city": selectedCity,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
    };
  }

  // ✅ Get cities for selected governorate
  List<String> get availableCities {
    if (selectedGovernorate == null) return [];
    return citiesByGovernorate[selectedGovernorate] ?? [];
  }
}

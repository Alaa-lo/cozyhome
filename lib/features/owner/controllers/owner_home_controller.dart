import 'package:flutter/material.dart';
import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:cozy_home_1/features/owner/service/owner_apartment_service.dart';

class OwnerHomeController extends ChangeNotifier {
  final OwnerApartmentService _service = OwnerApartmentService();

  List<Apartment> apartments = [];

  bool isLoading = false;
  String? errorMessage;

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
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final data = await _service.getMyApartments();
      apartments = data;

      if (apartments.isEmpty) {
        print("⚠️ No apartments found");
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching apartments: $e");
      isLoading = false;
      errorMessage = "Failed to load apartments";
      notifyListeners();
    }
  }

  // ---------------- OWNER APARTMENTS ----------------
  Future<void> loadOwnerApartments() async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _service.getOwnerApartments();
      apartments = data;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading owner apartments: $e");
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------- ADD APARTMENT ----------------
  void addApartment(Apartment apartment) {
    apartments.insert(0, apartment);
    notifyListeners();
  }

  Future<void> updateApartment(Apartment updated) async {
    try {
      await _service.updateApartment(updated);

      final index = apartments.indexWhere((a) => a.id == updated.id);
      if (index != -1) {
        // 🔥 دمج القديم مع الجديد بدل استبدال كامل
        apartments[index] = apartments[index].copyWith(
          title: updated.title,
          description: updated.description,
          city: updated.city,
          province: updated.province,
          pricePerNight: updated.pricePerNight,
          // الصور تبقى كما هي لأن السيرفر لا يرجعها
          images: apartments[index].images,
        );

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

    // 🔥 التحميل يتم مرة واحدة فقط عند فتح تبويب الشقق
    if (index == 1) {
      loadOwnerApartments();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

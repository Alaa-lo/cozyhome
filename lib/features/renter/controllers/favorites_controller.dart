import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final List<Map<String, dynamic>> favorites = [];

  void addToFavorites(Map<String, dynamic> booking) {
    if (!favorites.contains(booking)) {
      favorites.add(booking);
      notifyListeners();
    }
  }

  void removeFromFavorites(Map<String, dynamic> booking) {
    favorites.remove(booking);
    notifyListeners();
  }
}

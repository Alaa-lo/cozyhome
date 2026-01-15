import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:flutter/foundation.dart';

class ApartmentService {
  final ApiClient _apiClient = ApiClient();

  // ================================
  // 🔹 Get Apartments (Home Screen)
  // ================================
  Future<List<Apartment>> getApartments({
    String? city,
    String? province, // governorate
    double? minPrice, // NEW
    double? maxPrice, // UPDATED
  }) async {
    final Map<String, dynamic> queryParams = {};

    // 🔹 Filters
    if (city != null) queryParams['city'] = city;
    if (province != null) queryParams['province'] = province;
    if (minPrice != null) queryParams['min_price'] = minPrice;
    if (maxPrice != null) queryParams['max_price'] = maxPrice;

    try {
      final response = await _apiClient.get(
        ApiEndpoints.apartments,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // 🔍 إذا الـ API يرجع List مباشرة
        if (data is List) {
          return data.map((json) => Apartment.fromJson(json)).toList();
        }

        // 🔍 إذا الـ API يرجع { data: [...] }
        if (data is Map && data['data'] is List) {
          return (data['data'] as List)
              .map((json) => Apartment.fromJson(json))
              .toList();
        }

        debugPrint("⚠️ Unexpected apartments response format: $data");
      }
    } catch (e, s) {
      debugPrint("❌ Error in getApartments: $e");
      debugPrint("STACK: $s");
    }

    return [];
  }

  // ================================
  // 🔹 Apartment Details
  // ================================
  Future<Apartment?> getApartmentDetails(int id) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.apartmentDetails(id));

      if (response.statusCode == 200) {
        var data = response.data;
        if (data is Map && data.containsKey('data')) {
          data = data['data'];
        }
        return Apartment.fromJson(data);
      }
    } catch (e, s) {
      debugPrint("❌ Error in getApartmentDetails: $e");
      debugPrint("STACK: $s");
    }
    return null;
  }

  // ================================
  // 🔹 Toggle Favorite
  // ================================
  Future<bool> toggleFavorite(int apartmentId) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.toggleFavorite(apartmentId),
      );

      return response.statusCode == 200;
    } catch (e, s) {
      debugPrint("❌ Error in toggleFavorite: $e");
      debugPrint("STACK: $s");
      return false;
    }
  }

  // ================================
  // 🔹 Get Favorites
  // ================================
  Future<List<Apartment>> getFavorites() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.favorites);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data.map((json) => Apartment.fromJson(json)).toList();
        }

        if (data is Map && data['data'] is List) {
          return (data['data'] as List)
              .map((json) => Apartment.fromJson(json))
              .toList();
        }
      }
    } catch (e, s) {
      debugPrint("❌ Error in getFavorites: $e");
      debugPrint("STACK: $s");
    }

    return [];
  }
}

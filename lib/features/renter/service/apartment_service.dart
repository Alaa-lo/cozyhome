import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../models/apartment.dart';

class ApartmentService {
  final ApiClient _apiClient = ApiClient();

  // List apartments with filters
  Future<List<Apartment>> getApartments({
    String? city,
    String? province,
    double? maxPrice,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (city != null) queryParams['city'] = city;
    if (province != null) queryParams['province'] = province;
    if (maxPrice != null) queryParams['max_price'] = maxPrice;

    try {
      final response = await _apiClient.get(
        ApiEndpoints.apartments,
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Apartment.fromJson(json)).toList();
      }
    } catch (e) {
      // Handle error
    }
    return [];
  }

  // View apartment details
  Future<Apartment?> getApartmentDetails(int id) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.apartmentDetails(id));
      if (response.statusCode == 200) {
        return Apartment.fromJson(response.data);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  // Toggle Favorite
  Future<bool> toggleFavorite(int apartmentId) async {
    try {
      final response = await _apiClient.post(ApiEndpoints.toggleFavorite(apartmentId));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // List Favorites
  Future<List<Apartment>> getFavorites() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.favorites);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Apartment.fromJson(json)).toList();
      }
    } catch (e) {
      // Handle error
    }
    return [];
  }
}

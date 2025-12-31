import 'package:dio/dio.dart';
import 'dart:io';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../renter/models/apartment.dart';

class OwnerApartmentService {
  final ApiClient _apiClient = ApiClient();

  // Get My Apartments
  Future<List<Apartment>> getMyApartments() async {
    try {
      // Using documented apartments endpoint as no owner-specific one exists in doc
      final response = await _apiClient.get(ApiEndpoints.apartments);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Apartment.fromJson(json)).toList();
      }
    } catch (e) {
      // Handle error
    }
    return [];
  }

  // Create Apartment
  Future<Response> createApartment({
    required String title,
    required String description,
    required String city,
    required String province,
    required double pricePerNight,
    required List<File> images,
  }) async {
    List<MultipartFile> multipartImages = [];
    for (var image in images) {
      String fileName = image.path.split('/').last;
      multipartImages.add(
        await MultipartFile.fromFile(image.path, filename: fileName),
      );
    }

    FormData formData = FormData.fromMap({
      "title": title,
      "description": description,
      "city": city,
      "province": province,
      "price_per_night": pricePerNight,
      "images[]": multipartImages,
    });

    return await _apiClient.post(ApiEndpoints.apartments, data: formData);
  }

  // Update Apartment
  Future<Response> updateApartment(int id, {
    String? title,
    String? description,
    String? city,
    String? province,
    double? pricePerNight,
  }) async {
    final Map<String, dynamic> data = {};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (city != null) data['city'] = city;
    if (province != null) data['province'] = province;
    if (pricePerNight != null) data['price_per_night'] = pricePerNight;

    return await _apiClient.put(ApiEndpoints.apartmentDetails(id), data: data);
  }

  // Delete Apartment
  Future<bool> deleteApartment(int id) async {
    try {
      final response = await _apiClient.delete(ApiEndpoints.apartmentDetails(id));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Approve Booking
  Future<bool> approveBooking(int bookingId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.approveBooking(bookingId));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Reject Booking
  Future<bool> rejectBooking(int bookingId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.rejectBooking(bookingId));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

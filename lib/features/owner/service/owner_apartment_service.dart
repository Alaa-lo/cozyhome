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
      final response = await _apiClient.get(ApiEndpoints.apartments);

      if (response.statusCode == 200) {
        print("🔍 Apartments response: ${response.data}");

        // إذا الـ API يرجع بهالشكل: { "data": [ ... ] }
        final body = response.data;

        List list;

        if (body is List) {
          list = body;
        } else if (body is Map<String, dynamic> && body['data'] is List) {
          list = body['data'];
        } else {
          print("⚠️ Unexpected response format in getMyApartments");
          return [];
        }

        return list.map((json) => Apartment.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching apartments: $e");
    }
    return [];
  }

  // ---------------- CREATE APARTMENT ----------------
  Future<Apartment> createApartment({
    required Apartment apartment,
    required List<File> images,
  }) async {
    try {
      // تجهيز الصور
      List<MultipartFile> multipartImages = [];

      for (var image in images) {
        String fileName = image.path.split('/').last;
        multipartImages.add(
          await MultipartFile.fromFile(image.path, filename: fileName),
        );
      }

      // تجهيز البيانات
      FormData formData = FormData.fromMap({
        "title": apartment.title,
        "description": apartment.description,
        "city": apartment.city,
        "province": apartment.province,
        "address": apartment.address,
        "price_per_night": apartment.pricePerNight,
        "images[]": multipartImages,
      });

      // إرسال الطلب
      final response = await _apiClient.post(
        ApiEndpoints.apartments,
        data: formData,
      );

      // تحويل الرد إلى موديل Apartment
      return Apartment.fromJson(response.data);
    } catch (e) {
      print("Error creating apartment: $e");
      rethrow;
    }
  }

  // ---------------- UPDATE APARTMENT ----------------
  Future<Apartment> updateApartment(Apartment apartment) async {
    try {
      final data = {
        "title": apartment.title,
        "description": apartment.description,
        "city": apartment.city,
        "province": apartment.province,
        "price_per_night": apartment.pricePerNight,
      };

      final response = await _apiClient.put(
        ApiEndpoints.apartmentDetails(apartment.id!),
        data: data,
      );

      return Apartment.fromJson(response.data);
    } catch (e) {
      print("Error updating apartment: $e");
      rethrow;
    }
  }

  // ---------------- DELETE APARTMENT ----------------
  Future<bool> deleteApartment(int id) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.apartmentDetails(id),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // ---------------- OWNER BOOKING ACTIONS ----------------
  Future<bool> approveBooking(int bookingId) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoints.approveBooking(bookingId),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectBooking(int bookingId) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoints.rejectBooking(bookingId),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

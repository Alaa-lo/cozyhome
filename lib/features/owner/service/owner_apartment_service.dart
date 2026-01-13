import 'package:cozy_home_1/core/models/booking_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import 'package:cozy_home_1/core/models/apartment_model.dart';

class OwnerApartmentService {
  final ApiClient _apiClient = ApiClient();

  // Get My Apartments
  Future<List<Apartment>> getMyApartments() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.apartments);

      if (response.statusCode == 200) {
        final body = response.data;
        List list;

        if (body is List) {
          list = body;
        } else if (body is Map<String, dynamic> && body['data'] is List) {
          list = body['data'];
        } else {
          return [];
        }

        return list.map((json) => Apartment.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching apartments: $e");
    }
    return [];
  }

  // ---------------- OWNER APARTMENTS  ----------------
  Future<List<Apartment>> getOwnerApartments() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.ownerApartments);

      if (response.statusCode == 200) {
        final body = response.data;

        if (body is List) {
          return body.map((e) => Apartment.fromJson(e)).toList();
        }

        if (body is Map<String, dynamic> && body["data"] is List) {
          return (body["data"] as List)
              .map((e) => Apartment.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      print("Error fetching owner apartments: $e");
    }

    return [];
  }

  // ---------------- CREATE APARTMENT ----------------
  Future<Apartment> createApartment({
    required Apartment apartment,
    required List<File> images,
  }) async {
    try {
      List<MultipartFile> multipartImages = [];
      for (var image in images) {
        multipartImages.add(
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        );
      }

      FormData formData = FormData.fromMap({
        "apartment_name": apartment.title,
        "governorate": apartment.province,
        "city": apartment.city,
        "detailed_address": apartment.address,
        "price": apartment.pricePerNight.toString(),
        "rent_type": apartment.rentType.toLowerCase(),
        "description": apartment.description,
        "images[]": multipartImages,
      });

      final response = await _apiClient.post(
        ApiEndpoints.apartments,
        data: formData,
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('data')) {
          return Apartment.fromJson(data['data']);
        }
        if (data.containsKey('apartment')) {
          return Apartment.fromJson(data['apartment']);
        }
        return Apartment.fromJson(data);
      }

      throw Exception("Unexpected response format");
    } catch (e) {
      print("❌ Error creating apartment detail: $e");
      rethrow;
    }
  }

  // ---------------- UPDATE APARTMENT ----------------
  Future<Apartment> updateApartment(Apartment apartment) async {
    try {
      final data = {
        "apartment_name": apartment.title,
        "governorate": apartment.province,
        "city": apartment.city,
        "detailed_address": apartment.address,
        "price": apartment.pricePerNight,
        "rent_type": apartment.rentType.toLowerCase(),
        "description": apartment.description,
      };

      final response = await _apiClient.put(
        ApiEndpoints.apartmentDetails(apartment.id!),
        data: data,
      );

      final responseData = response.data;
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data')) {
        return Apartment.fromJson(responseData['data']);
      }
      return Apartment.fromJson(response.data);
    } catch (e) {
      print("Error updating apartment: $e");
      rethrow;
    }
  }

  // ---------------- DELETE / APPROVE / REJECT ----------------
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

  //-------------------owner bookings--------------------------//
  Future<List<Booking>> getOwnerBookings() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.ownerBookings);

      if (response.statusCode == 200) {
        final body = response.data;

        if (body is List) {
          return body.map((e) => Booking.fromJson(e)).toList();
        }

        if (body is Map<String, dynamic> && body["data"] is List) {
          return (body["data"] as List)
              .map((e) => Booking.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      print("Error fetching owner bookings: $e");
    }

    return [];
  }
}

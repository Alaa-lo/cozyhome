import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import 'package:cozy_home_1/core/models/booking_model.dart';

class BookingService {
  final ApiClient _apiClient = ApiClient();

  // ---------------- CREATE BOOKING ----------------
  Future<Booking> createBooking({
    required int apartmentId,
    required String startDate,
    required String endDate,
    required int numberOfPersons,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.bookings,
        data: {
          "apartment_id": apartmentId,
          "start_date": startDate,
          "end_date": endDate,
          "number_of_persons": numberOfPersons,
          "notes": notes,
        },
      );

      // استخراج بيانات الحجز من الريسبونس
      final bookingJson = response.data["booking"];

      return Booking.fromJson(bookingJson);
    } on DioException catch (e) {
      debugPrint("❌ Booking Error: ${e.response?.data}");
      throw Exception("Failed to create booking");
    }
  }

  // ---------------- GET MY BOOKINGS ----------------
  // ---------------- GET MY BOOKINGS (المعدل) ----------------
  Future<List<Booking>> getMyBookings() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.myBookings);
      print("response");
      if (response.statusCode == 200) {
        final data = response.data;
        final List<Booking> all = [];

        if (data['current'] != null) {
          all.addAll((data['current'] as List).map((e) => Booking.fromJson(e)));
        }

        if (data['previous'] != null) {
          all.addAll(
            (data['previous'] as List).map((e) => Booking.fromJson(e)),
          );
        }

        if (data['canceled'] != null) {
          all.addAll(
            (data['canceled'] as List).map((e) => Booking.fromJson(e)),
          );
        }

        // ملاحظة: إذا كان الباك أند يرسل أيضاً قائمة 'pending' أو 'upcoming' أضفها هنا
        if (data['pending'] != null) {
          all.addAll((data['pending'] as List).map((e) => Booking.fromJson(e)));
        }

        return all;
      }
    } catch (e) {
      debugPrint("❌ Error in getMyBookings Service: $e");
    }

    return [];
  }

  // ---------------- CANCEL BOOKING ----------------
  Future<bool> cancelBooking(int bookingId) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoints.cancelBooking(bookingId),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // ---------------- SUBMIT REVIEW ----------------
  Future<bool> submitReview(
    int bookingId, {
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.reviewBooking(bookingId),
        data: {"rating": rating, "comment": comment},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // ---------------- UPDATE BOOKING ----------------
  Future<Booking> updateBooking({
    required int bookingId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoints.updateBooking(bookingId),
        data: {"start_date": startDate, "end_date": endDate},
      );

      if (response.statusCode == 200 && response.data["booking"] != null) {
        return Booking.fromJson(response.data["booking"]);
      } else {
        throw Exception("Unexpected server response");
      }
    } on DioException catch (e) {
      final serverMessage = e.response?.data?["message"] ?? "Update failed";
      throw Exception(serverMessage);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}

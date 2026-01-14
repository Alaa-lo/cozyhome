import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import 'package:cozy_home_1/core/models/booking_model.dart';

class BookingService {
  final ApiClient _apiClient = ApiClient();

  // Create Booking
  Future<Response> createBooking({
    required int apartmentId,
    required String startDate,
    required String endDate,
    required int numberOfPersons,
    String? notes,
  }) async {
    return await _apiClient.post(
      ApiEndpoints.bookings,
      data: {
        "apartment_id": apartmentId,
        "start_date": startDate,
        "end_date": endDate,
        "number_of_persons": numberOfPersons,
        "notes": notes,
      },
    );
  }

  Future<List<Booking>> getMyBookings() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.myBookings);

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

        return all;
      }
    } catch (e) {
      debugPrint("Error in getMyBookings: $e");
    }

    return [];
  }

  // Cancel Booking
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

  // Submit Review
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
}

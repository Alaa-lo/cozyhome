import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../models/booking.dart';

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

  // Get My Bookings
  Future<List<Booking>> getMyBookings() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.myBookings);
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Booking.fromJson(json)).toList();
      }
    } catch (e) {
      // Handle error
    }
    return [];
  }

  // Cancel Booking
  Future<bool> cancelBooking(int bookingId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.cancelBooking(bookingId));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Submit Review
  Future<bool> submitReview(int bookingId, {required int rating, String? comment}) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.reviewBooking(bookingId),
        data: {
          "rating": rating,
          "comment": comment,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

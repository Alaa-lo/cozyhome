import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';
import '../features/auth/models/user.dart';

class AdminService {
  final ApiClient _apiClient = ApiClient();

  Future<List<User>> getPendingUsers() async {
    // This endpoint is not in the documentation, returning empty list to avoid 404 errors
    return [];
  }

  Future<bool> approveUser(int userId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.approveUser(userId));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // rejectUser removed as it is not in documentation
}

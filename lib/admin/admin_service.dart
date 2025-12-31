import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';
import '../features/auth/models/user.dart';

class AdminService {
  final ApiClient _apiClient = ApiClient();

  Future<List<User>> getPendingUsers() async {
    try {
      final response = await _apiClient.get("/admin/pending-users"); // Correct this if endpoint is different
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      // Handle error
    }
    return [];
  }

  Future<bool> approveUser(int userId) async {
    try {
      final response = await _apiClient.post("/admin/approve-user/$userId");
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectUser(int userId) async {
    try {
      final response = await _apiClient.post("/admin/reject-user/$userId");
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

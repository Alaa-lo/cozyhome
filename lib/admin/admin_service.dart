import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';
import '../features/auth/models/user.dart';

class AdminService {
  final ApiClient _apiClient = ApiClient();

  /// جلب المستخدمين بانتظار الموافقة
  Future<List<User>> getPendingUsers() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.pendingUsers);

      if (response.statusCode == 200) {
        final body = response.data;

        // إذا رجع السيرفر List مباشرة
        if (body is List) {
          return body.map((json) => User.fromJson(json)).toList();
        }

        // إذا رجع Map وفيه مفتاح data
        if (body is Map<String, dynamic> && body['data'] is List) {
          final List<dynamic> data = body['data'];
          return data.map((json) => User.fromJson(json)).toList();
        }

        debugPrint("Unexpected response format: $body");
        return [];
      } else {
        debugPrint("getPendingUsers failed: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Error in getPendingUsers: $e");
      return [];
    }
  }

  /// الموافقة على مستخدم
  Future<bool> approveUser(int userId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.approveUser(userId));
      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint("approveUser failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Error in approveUser: $e");
      return false;
    }
  }

  /// رفض مستخدم
  Future<bool> rejectUser(int userId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.rejectUser(userId));
      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint("rejectUser failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Error in rejectUser: $e");
      return false;
    }
  }

  /// تسجيل دخول الأدمن
  Future<User?> loginAdmin(String phone, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.adminlogin,
        data: {"phonenumber": phone, "password": password},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // إذا الـ API بيرجع user + token
        final prefs = await SharedPreferences.getInstance();
        if (data['token'] != null) {
          await prefs.setString('token', data['token']);
        }

        // إذا الـ API بيرجع user داخل مفتاح user
        if (data['user'] != null) {
          return User.fromJson(data['user']);
        }

        // إذا بيرجع مباشرةً بيانات المستخدم
        return User.fromJson(data);
      } else {
        debugPrint("loginAdmin failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error in loginAdmin: $e");
      return null;
    }
  }
}

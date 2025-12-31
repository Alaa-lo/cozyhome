import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../models/user.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // ---------------------------
  // REGISTER
  // ---------------------------
  Future<Response> register({
    required String fullname,
    required String phonenumber,
    required String password,
    required String passwordConfirmation,
    required String role,
    required String birthDate,
    required File profileImage,
    required File idImage,
  }) async {
    String profileImageName = profileImage.path.split('/').last;
    String idImageName = idImage.path.split('/').last;

    FormData formData = FormData.fromMap({
      "fullname": fullname,
      "phonenumber": phonenumber,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "role": role,
      "birth_date": birthDate,
      "profile_image": await MultipartFile.fromFile(profileImage.path, filename: profileImageName),
      "id_image": await MultipartFile.fromFile(idImage.path, filename: idImageName),
    });

    return await _apiClient.post(ApiEndpoints.register, data: formData);
  }

  // ---------------------------
  // LOGIN
  // ---------------------------
  Future<Map<String, dynamic>> login({
    required String phonenumber,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {"phonenumber": phonenumber, "password": password},
    );

    final data = response.data;
    final token = data["token"] ?? data["access_token"];

    // Save token if exists
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
    }

    return data;
  }

  // ---------------------------
  // LOGOUT
  // ---------------------------
  Future<bool> logout() async {
    try {
      final response = await _apiClient.post(ApiEndpoints.logout);
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove("token");
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  // ---------------------------
  // GET PROFILE
  // ---------------------------
  Future<User?> getProfile() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.profile);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://172.16.0.8:8000/api";

  // ---------------------------
  // REGISTER (مرحلة أولى)
  // ---------------------------
  static Future<Map<String, dynamic>> register({
    required String fullname,
    required String phonenumber,
    required String password,
    required String role,
  }) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {
        "fullname": fullname,
        "mobile_number": phonenumber, // ⭐ مهم جداً
        "password": password,
        "role": role,
      },
    );

    final data = jsonDecode(response.body);
    return data;
  }

  // ---------------------------
  // COMPLETE PROFILE (مرحلة ثانية)
  // ---------------------------
  static Future<http.StreamedResponse> completeProfile({
    required String birthDate,
    required String profileImagePath,
    required String idImagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    var url = Uri.parse("$baseUrl/profile");

    var request = http.MultipartRequest("POST", url);

    request.headers["Authorization"] = "Bearer $token";
    request.headers["Accept"] = "application/json";

    request.fields["birth_date"] = birthDate;

    request.files.add(
      await http.MultipartFile.fromPath("profile_image", profileImagePath),
    );

    request.files.add(
      await http.MultipartFile.fromPath("id_image", idImagePath),
    );

    return await request.send();
  }

  // ---------------------------
  // LOGIN
  // ---------------------------
  static Future<Map<String, dynamic>> login({
    required String phonenumber,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {
        "mobile_number": phonenumber, // ⭐ مهم جداً
        "password": password,
      },
    );

    final data = jsonDecode(response.body);

    // Save token if exists
    if (data["access_token"] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["access_token"]);
    }

    return data;
  }

  // ---------------------------
  // LOGOUT
  // ---------------------------
  static Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) return false;

    final url = Uri.parse("$baseUrl/logout");

    final response = await http.post(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      await prefs.remove("token");
      return true;
    }

    return false;
  }

  // ---------------------------
  // GET PROFILE
  // ---------------------------
  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final url = Uri.parse("$baseUrl/profile");

    final response = await http.get(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    return jsonDecode(response.body);
  }
}

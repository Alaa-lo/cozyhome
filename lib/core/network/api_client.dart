import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint("🚀 Sending request with token: Bearer $token");
          } else {
            debugPrint("⚠️ No token found in SharedPreferences");
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          debugPrint("API ERROR: ${error.response?.statusCode}");
          debugPrint("API BODY: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.put(path, data: data, queryParameters: queryParameters);
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.patch(path, data: data, queryParameters: queryParameters);
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(path, data: data, queryParameters: queryParameters);
  }

  // ✅ دالة جديدة لرفع الملفات (multipart/form-data)
  Future<Response> upload(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, File> files,
  }) async {
    // Create FormData with fields and files
    final formData = FormData.fromMap({
      ...fields,
      for (var entry in files.entries)
        entry.key: await MultipartFile.fromFile(
          entry.value.path,
          filename: entry.value.path.split('/').last,
        ),
    });

    // Post request - Dio will automatically set Content-Type to multipart/form-data
    return await dio.post(
      path,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {'Accept': 'application/json'},
      ),
    );
  }
}

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
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
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

          options.headers['ngrok-skip-browser-warning'] = 'true';
          options.headers['Accept'] = 'application/json';

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

  // ---------------------- GET ----------------------
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
        },
      ),
    );
  }

  // ---------------------- POST ----------------------
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
            'Accept': 'application/json',
          },
          contentType: data is FormData ? null : 'application/json',
        ),
      );
    } on DioException catch (e) {
      print("Dio Error Path: ${e.requestOptions.path}");
      print("Dio Error Message: ${e.message}");
      print("Dio Error Response: ${e.response?.data}");
      rethrow;
    }
  }

  // ---------------------- PUT ----------------------
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  // ---------------------- PATCH ----------------------
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
        },
      ),
    );
  }

  // ---------------------- DELETE ----------------------
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
        },
      ),
    );
  }

  // ---------------------- UPLOAD (multipart) ----------------------
  Future<Response> upload(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, File> files,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final formData = FormData.fromMap({
      ...fields,
      for (var entry in files.entries)
        entry.key: await MultipartFile.fromFile(
          entry.value.path,
          filename: entry.value.path.split('/').last,
        ),
    });

    return await dio.post(
      path,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
        },
        contentType: 'multipart/form-data',
      ),
    );
  }
}

// lib/data/datasources/auth_api.dart
//
// Raw HTTP calls to the backend's /auth endpoints. This is the ONLY file
// that knows about the specific request/response shape of those endpoints —
// everything above it (the repository) works with clean Dart objects instead.

import 'package:dio/dio.dart';

class AuthApiException implements Exception {
  AuthApiException(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() => message;
}

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'email': email,
        'password': password,
        if (displayName != null) 'displayName': displayName,
      });
      return response.data['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _toAuthException(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _toAuthException(e);
    }
  }

  // Turns Dio's generic network error into our own AuthApiException, using
  // the backend's standard error shape: { success:false, error:{code,message} }
  AuthApiException _toAuthException(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['error'] is Map) {
      final error = data['error'] as Map;
      return AuthApiException(
        error['message'] as String? ?? 'Something went wrong.',
        code: error['code'] as String?,
      );
    }
    return AuthApiException('Could not reach the server. Check your connection.');
  }
}

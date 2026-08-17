// lib/core/network/dio_client.dart
//
// A single, shared Dio instance for every API call in the app. An
// interceptor automatically attaches "Authorization: Bearer <token>" to
// every outgoing request (when a token exists) — so individual API calls
// never need to worry about auth headers themselves.

import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

class DioClient {
  DioClient(this._secureStorage) : dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.readAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  final Dio dio;
  final SecureStorage _secureStorage;
}

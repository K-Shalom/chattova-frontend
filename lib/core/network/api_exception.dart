// lib/core/network/api_exception.dart
//
// A generic exception type for ANY backend API call (not just auth) —
// reused across conversations, users, messages, etc. Converts Dio's raw
// network error into the backend's standard error shape:
// { success:false, error:{code,message} }

import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.code, this.statusCode});

  final String message;
  final String? code;
  final int? statusCode;

  @override
  String toString() => message;

  factory ApiException.fromDioException(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['error'] is Map) {
      final error = data['error'] as Map;
      return ApiException(
        error['message'] as String? ?? 'Something went wrong.',
        code: error['code'] as String?,
        statusCode: e.response?.statusCode,
      );
    }
    return ApiException('Could not reach the server. Check your connection.');
  }
}

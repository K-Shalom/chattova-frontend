// lib/data/datasources/users_api.dart

import 'package:dio/dio.dart';
import '../../core/network/api_exception.dart';

class UsersApi {
  UsersApi(this._dio);

  final Dio _dio;

  Future<List<Map<String, dynamic>>> search(String query) async {
    try {
      final response = await _dio.get('/users/search', queryParameters: {'q': query});
      return (response.data['data'] as List).cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
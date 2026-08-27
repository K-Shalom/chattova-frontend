// lib/data/datasources/conversations_api.dart

import 'package:dio/dio.dart';
import '../../core/network/api_exception.dart';

class ConversationsApi {
  ConversationsApi(this._dio);

  final Dio _dio;

  Future<List<Map<String, dynamic>>> listMine() async {
    try {
      final response = await _dio.get('/conversations');
      return (response.data['data'] as List).cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Map<String, dynamic>> createDirect(String otherUserId) async {
    try {
      final response = await _dio.post('/conversations/direct', data: {'otherUserId': otherUserId});
      return response.data['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
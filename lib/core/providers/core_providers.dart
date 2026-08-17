// lib/core/providers/core_providers.dart
//
// The "wiring" file — creates one shared instance of each core service
// (storage, network client, API, repository) that the rest of the app
// reads via `ref.watch(...)` instead of constructing manually everywhere.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_api.dart';
import '../../data/repositories/auth_repository.dart';
import '../network/dio_client.dart';
import '../storage/secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref.watch(secureStorageProvider));
});

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(dioClientProvider).dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authApiProvider), ref.watch(secureStorageProvider));
});

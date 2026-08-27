// lib/core/providers/core_providers.dart
//
// The "wiring" file — one shared instance of each core service.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_api.dart';
import '../../data/datasources/conversations_api.dart';
import '../../data/datasources/users_api.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/conversations_repository.dart';
import '../../data/repositories/users_repository.dart';
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

final conversationsApiProvider = Provider<ConversationsApi>((ref) {
  return ConversationsApi(ref.watch(dioClientProvider).dio);
});

final conversationsRepositoryProvider = Provider<ConversationsRepository>((ref) {
  return ConversationsRepository(ref.watch(conversationsApiProvider));
});

final usersApiProvider = Provider<UsersApi>((ref) {
  return UsersApi(ref.watch(dioClientProvider).dio);
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository(ref.watch(usersApiProvider));
});

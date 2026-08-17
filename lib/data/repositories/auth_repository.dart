// lib/data/repositories/auth_repository.dart
//
// The single place the rest of the app calls for anything auth-related.
// It combines the raw API (AuthApi) with local storage (SecureStorage) —
// e.g. after a successful login, this is what saves the tokens.

import '../../core/storage/secure_storage.dart';
import '../../domain/models/chattova_user.dart';
import '../datasources/auth_api.dart';

class AuthRepository {
  AuthRepository(this._authApi, this._secureStorage);

  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  Future<ChattovaUser> register({
    required String username,
    required String email,
    required String password,
    String? displayName,
  }) async {
    final data = await _authApi.register(
      username: username,
      email: email,
      password: password,
      displayName: displayName,
    );
    await _saveTokensFrom(data);
    return ChattovaUser.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<ChattovaUser> login({required String email, required String password}) async {
    final data = await _authApi.login(email: email, password: password);
    await _saveTokensFrom(data);
    return ChattovaUser.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<void> logout() async {
    await _secureStorage.clearTokens();
  }

  // Used at app startup to decide: go to login screen, or straight to home?
  Future<bool> hasSavedSession() async {
    final token = await _secureStorage.readAccessToken();
    return token != null;
  }

  Future<void> _saveTokensFrom(Map<String, dynamic> data) async {
    await _secureStorage.saveTokens(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}

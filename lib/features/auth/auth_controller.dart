// lib/features/auth/auth_controller.dart
//
// The single place that handles register/login/logout actions and holds
// the current AuthState. Screens call these methods and watch authControllerProvider
// to react to loading/error/success — they never talk to AuthRepository directly.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../data/datasources/auth_api.dart';
import 'auth_state.dart';

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Kick off the startup session check without blocking the initial state.
    Future.microtask(checkSavedSession);
    return const AuthState();
  }

  Future<void> checkSavedSession() async {
    final repository = ref.read(authRepositoryProvider);
    final hasSession = await repository.hasSavedSession();
    // NOTE: this only checks whether a token exists locally — it doesn't yet
    // verify the token is still valid or re-fetch the user's profile. Once
    // we build GET /users/me, this can also refresh `user` on startup.
    state = state.copyWith(
      status: hasSession ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.register(
        username: username,
        email: email,
        password: password,
        displayName: displayName,
      );
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } on AuthApiException catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(email: email, password: password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } on AuthApiException catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(AuthController.new);

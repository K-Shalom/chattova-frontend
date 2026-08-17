// lib/features/auth/auth_state.dart
//
// Describes everything the UI needs to know about the current auth
// situation, as a single status: initial -> loading -> authenticated /
// unauthenticated / error. Screens switch on `status` to decide what to show.

import '../../domain/models/chattova_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  final AuthStatus status;
  final ChattovaUser? user;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    ChattovaUser? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}

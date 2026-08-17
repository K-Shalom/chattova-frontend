// lib/routes/app_router.dart
//
// Central navigation config. The `redirect` function runs before every
// navigation and decides — based on the current AuthState — whether the
// user is even allowed to go where they're trying to go. This is what makes
// "you must be logged in to see /home" and "don't show /login if you're
// already logged in" work automatically, everywhere, without repeating that
// logic in every screen.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/auth_state.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
    redirect: (context, state) {
      final isOnSplash = state.matchedLocation == '/';
      final isOnAuthScreen = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      switch (authState.status) {
        case AuthStatus.initial:
        case AuthStatus.loading:
          // Still figuring out login state — stay on splash if we're there,
          // otherwise let the current navigation proceed as-is.
          return isOnSplash ? null : null;

        case AuthStatus.unauthenticated:
        case AuthStatus.error:
          // Not logged in — always end up on /login unless already on an auth screen.
          return isOnAuthScreen ? null : '/login';

        case AuthStatus.authenticated:
          // Logged in — bounce away from splash/login/register straight to /home.
          return (isOnSplash || isOnAuthScreen) ? '/home' : null;
      }
    },
  );
});

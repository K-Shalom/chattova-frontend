// lib/routes/app_router.dart
//
// GoRouter is created ONCE and lives for the whole app session. It listens
// for auth changes via `refreshListenable`, which re-runs `redirect` below
// WITHOUT recreating the router or resetting the current location.
//
// The authenticated area (/chats, /contacts, /calls, /settings) uses a
// StatefulShellRoute so each tab keeps its own navigation state when you
// switch away and back (see AppShell).

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/auth_state.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/calls/calls_screen.dart';
import '../features/chats/chats_screen.dart';
import '../features/contacts/contacts_screen.dart';
import '../features/home/app_shell.dart';
import '../features/settings/settings_screen.dart';
import '../features/splash/splash_screen.dart';

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (previous, next) {
      if (previous?.status != next.status) {
        notifyListeners();
      }
    });
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _AuthRefreshNotifier(ref);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refreshNotifier,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/chats', builder: (context, state) => const ChatsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/contacts', builder: (context, state) => const ContactsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/calls', builder: (context, state) => const CallsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
          ]),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isOnSplash = state.matchedLocation == '/';
      final isOnAuthScreen = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      switch (authState.status) {
        case AuthStatus.initial:
        case AuthStatus.loading:
          return null;

        case AuthStatus.unauthenticated:
        case AuthStatus.error:
          return isOnAuthScreen ? null : '/login';

        case AuthStatus.authenticated:
          return (isOnSplash || isOnAuthScreen) ? '/chats' : null;
      }
    },
  );
});

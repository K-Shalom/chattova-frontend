import 'package:chattova/core/providers/core_providers.dart';
import 'package:chattova/data/datasources/auth_api.dart';
import 'package:chattova/data/repositories/auth_repository.dart';
import 'package:chattova/domain/models/chattova_user.dart';
import 'package:chattova/features/auth/auth_controller.dart';
import 'package:chattova/features/auth/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements AuthRepository {
  bool savedSession = false;
  bool rejectLogin = false;
  bool loggedOut = false;

  static const user = ChattovaUser(
    id: 'test-user', username: 'tester', displayName: 'Test User',
    email: 'tester@example.com', isVerified: false,
  );

  @override
  Future<bool> hasSavedSession() async => savedSession;

  @override
  Future<ChattovaUser> login({required String email, required String password}) async {
    if (rejectLogin) throw AuthApiException('Invalid email or password.');
    return user;
  }

  @override
  Future<ChattovaUser> register({required String username, required String email,
    required String password, String? displayName}) async => user;

  @override
  Future<void> logout() async { loggedOut = true; }
}

void main() {
  late FakeAuthRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeAuthRepository();
    container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(repository),
    ]);
  });
  tearDown(() => container.dispose());

  Future<void> initialize() async {
    container.read(authControllerProvider);
    await Future<void>.delayed(Duration.zero);
  }

  test('startup without a saved session requires login', () async {
    await initialize();
    expect(container.read(authControllerProvider).status, AuthStatus.unauthenticated);
  });

  test('successful login exposes the authenticated user', () async {
    await initialize();
    await container.read(authControllerProvider.notifier).login(
      email: 'tester@example.com', password: 'test-password',
    );
    expect(container.read(authControllerProvider).status, AuthStatus.authenticated);
    expect(container.read(authControllerProvider).user?.id, 'test-user');
  });

  test('rejected credentials produce a readable login error', () async {
    await initialize();
    repository.rejectLogin = true;
    await container.read(authControllerProvider.notifier).login(
      email: 'tester@example.com', password: 'wrong-password',
    );
    expect(container.read(authControllerProvider).status, AuthStatus.error);
    expect(container.read(authControllerProvider).errorMessage, 'Invalid email or password.');
  });

  test('logout clears user state and invokes token removal', () async {
    await initialize();
    final controller = container.read(authControllerProvider.notifier);
    await controller.login(email: 'tester@example.com', password: 'test-password');
    await controller.logout();
    expect(repository.loggedOut, isTrue);
    expect(container.read(authControllerProvider).status, AuthStatus.unauthenticated);
    expect(container.read(authControllerProvider).user, isNull);
  });
}

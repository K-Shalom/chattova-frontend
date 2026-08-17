// lib/features/home/home_screen.dart
//
// Placeholder home screen — just proves login/register worked and lets us
// test logout. This becomes the real conversations list in the next phase.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chattova'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          user != null ? 'Welcome, ${user.displayName}! 🎉' : 'Welcome!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

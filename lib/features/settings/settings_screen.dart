// lib/features/settings/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          if (user != null)
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user.displayName),
              subtitle: Text('@${user.username}'),
            ),
          const Divider(),
          const ListTile(leading: Icon(Icons.palette_outlined), title: Text('Appearance')),
          const ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifications')),
          const ListTile(leading: Icon(Icons.lock_outline), title: Text('Privacy & Security')),
          const ListTile(leading: Icon(Icons.devices_outlined), title: Text('Devices')),
          const ListTile(leading: Icon(Icons.block_outlined), title: Text('Blocked Users')),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log out', style: TextStyle(color: Colors.red)),
            onTap: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }
}

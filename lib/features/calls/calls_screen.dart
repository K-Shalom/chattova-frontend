// lib/features/calls/calls_screen.dart
import 'package:flutter/material.dart';
import '../../shared/widgets/empty_state.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calls')),
      body: const EmptyState(
        icon: Icons.call_outlined,
        title: 'No calls yet',
        subtitle: 'Your call history will show up here.',
      ),
    );
  }
}

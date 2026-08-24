// lib/features/contacts/contacts_screen.dart
import 'package:flutter/material.dart';
import '../../shared/widgets/empty_state.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: const EmptyState(
        icon: Icons.people_outline_rounded,
        title: 'Find people on Chattova',
        subtitle: 'Search by username to add someone to your contacts.',
      ),
    );
  }
}

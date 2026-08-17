// lib/app/app.dart
//
// The root widget of the whole app — now using MaterialApp.router so
// navigation is driven by app_router.dart (which in turn reacts to
// AuthState to decide what screen you're allowed to see).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../routes/app_router.dart';

class ChattovaApp extends ConsumerWidget {
  const ChattovaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Chattova',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

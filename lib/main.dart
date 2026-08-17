// lib/main.dart
//
// App entry point. ProviderScope enables Riverpod (state management) for
// the entire widget tree below it — every screen we build will be able to
// read/write shared state (like "am I logged in?") through it.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  runApp(const ProviderScope(child: ChattovaApp()));
}

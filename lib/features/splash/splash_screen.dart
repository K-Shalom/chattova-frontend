// lib/features/splash/splash_screen.dart
//
// First screen shown when the app opens. For now it's just branding — once
// we build the auth flow, this will check whether a saved access token
// exists and route to either the login screen or the home screen.

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the current theme's text color (adapts to light/dark automatically)
    // instead of a hardcoded color — otherwise text can become invisible
    // against a matching background, as happened in dark mode.
    final wordmarkColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2E7BFA), Color(0xFF7A3FE0)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Center(
                child: Text(
                  'C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: wordmarkColor,
                ),
                children: const [
                  TextSpan(text: 'Chattov'),
                  TextSpan(
                    text: 'a',
                    style: TextStyle(color: AppColors.primaryLight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: AppColors.primaryLight),
          ],
        ),
      ),
    );
  }
}

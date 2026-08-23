// lib/features/splash/splash_screen.dart
//
// First screen shown when the app opens. AuthController checks for a saved
// session in the background; app_router.dart redirects away from here once
// that check resolves.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/chattova_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ChattovaLogo(iconSize: 72),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

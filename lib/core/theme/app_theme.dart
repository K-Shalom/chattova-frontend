// lib/core/theme/app_theme.dart
//
// Chattova's design system colors — a warm orange-coral palette chosen for
// accessibility (WCAG AA contrast) rather than the default Flutter blue.
// Both light and dark variants are defined here so the whole app can react
// to the user's theme preference (see settings: appearance.theme).

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand accent (same across light/dark, this is what makes it "Chattova")
  static const Color primaryLight = Color(0xFFC1633F); // warm orange-coral
  static const Color primaryDark = Color(0xFF7A3E28); // deeper fill for dark mode

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFDFAF8); // warm off-white
  static const Color backgroundDark = Color(0xFF1C1917); // warm near-black

  // Text
  static const Color textLight = Color(0xFF1C1917);
  static const Color textDark = Color(0xFFF5E6DD); // warm cream
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      surface: AppColors.backgroundLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: Typography.blackMountainView.apply(
        bodyColor: AppColors.textLight,
        displayColor: AppColors.textLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textLight,
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight, // keep the accent recognizable in dark mode too
      surface: AppColors.backgroundDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: Typography.whiteMountainView.apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
    );
  }
}

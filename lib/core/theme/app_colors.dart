// lib/core/theme/app_colors.dart
//
// Every color used anywhere in Chattova comes from here — screens never
// hardcode a hex value. Matches docs/design/Chattova_Design_System_v1.md §1.

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFFC1633F);   // muted terracotta/coral
  static const Color primaryDark = Color(0xFF7A3E28); // dark-mode coral surfaces (never bright coral on dark bg)
  static const Color secondary = Color(0xFF6B8F71);  // muted sage green

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFDFAF8); // warm off-white, never pure white
  static const Color backgroundDark = Color(0xFF1C1917);  // warm near-black, never pure black
  static const Color surfaceDark = Color(0xFF2A2521);

  // Text
  static const Color textLight = Color(0xFF1C1917);
  static const Color textDark = Color(0xFFF5E6DD); // warm cream
  static const Color mutedTextLight = Color(0xFF6B6360);
  static const Color mutedTextDark = Color(0xFFB8ADA6);

  // Structural
  static const Color inputBorder = Color(0xFFE4DDD5);

  // Semantic (never use brand coral for these)
  static const Color success = Color(0xFF3F8B4C);
  static const Color warning = Color(0xFFB8860B);
  static const Color error = Color(0xFFC0392B);
}

// lib/core/theme/app_typography.dart
//
// Inter for all UI text (nav, labels, buttons, messages, forms — per design
// system v2), weights 400/500 only. Poppins Bold is reserved ONLY for the
// "Chattova" wordmark itself (the logotype), never for body/headline text —
// that's what gives the brand name its distinct, Instagram-like presence
// without making the whole app feel heavy.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  // The Chattova logotype style — used only in the brand lockup (splash,
  // auth screens, app bar), never for section headlines.
  static TextStyle wordmark({required Color color, double fontSize = 22}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: -0.3,
    );
  }

  static TextTheme textTheme({required Color textColor, required Color mutedColor}) {
    final base = GoogleFonts.interTextTheme();
    return base.copyWith(
      displayLarge: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w500, color: textColor),
      displayMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w500, color: textColor),
      displaySmall: GoogleFonts.inter(fontSize: 19, fontWeight: FontWeight.w600, color: textColor),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: textColor),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: textColor),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: mutedColor),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: mutedColor),
      titleLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
    );
  }
}

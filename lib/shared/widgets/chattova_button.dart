// lib/shared/widgets/chattova_button.dart
//
// Standard primary button — asymmetric radius (mirrored, sharp bottom-left),
// coral fill. Uses the theme's ElevatedButtonTheme, so this widget mainly
// adds a loading-spinner state so every screen handles "submitting..." the
// same way instead of reinventing it.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ChattovaButton extends StatelessWidget {
  const ChattovaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Theme.of(context).colorScheme.brightness == Brightness.dark
                      ? AppColors.textDark
                      : AppColors.backgroundLight,
                ),
              )
            : Text(label),
      ),
    );
  }
}

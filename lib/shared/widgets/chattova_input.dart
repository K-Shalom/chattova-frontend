// lib/shared/widgets/chattova_input.dart
//
// Standard text field: sentence-case label ABOVE the field (not a floating
// label), asymmetric radius from the theme's InputDecorationTheme.

import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class ChattovaInput extends StatelessWidget {
  const ChattovaInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(errorText: errorText),
        ),
      ],
    );
  }
}

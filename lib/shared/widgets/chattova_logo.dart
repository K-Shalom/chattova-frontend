// lib/shared/widgets/chattova_logo.dart
//
// The brand lockup used on splash and auth screens: gradient rounded-square
// icon (chat bubble symbol, orange->coral gradient) + "Chattova" wordmark in
// Poppins Bold. Centralized here so the logo never drifts between screens.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ChattovaLogo extends StatelessWidget {
  const ChattovaLogo({super.key, this.iconSize = 64, this.showWordmark = true});

  final double iconSize;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final wordmarkColor = Theme.of(context).colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF7A45), AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(iconSize * 0.31),
          ),
          child: Icon(
            Icons.chat_bubble_rounded,
            color: AppColors.backgroundLight,
            size: iconSize * 0.47,
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(height: 14),
          Text('Chattova', style: AppTypography.wordmark(color: wordmarkColor)),
        ],
      ],
    );
  }
}

// lib/shared/widgets/chattova_avatar.dart
//
// Chattova NEVER uses circular avatars (design system §5) — rounded-square
// only, with online presence shown as a small dot, not a ring around a circle.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ChattovaAvatar extends StatelessWidget {
  const ChattovaAvatar({
    super.key,
    this.imageUrl,
    required this.fallbackText,
    this.size = 48,
    this.isOnline = false,
  });

  final String? imageUrl;
  final String fallbackText; // e.g. first letter of display name
  final double size;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size * 0.22); // ~14px at 64px size, scales proportionally

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: radius,
          child: imageUrl != null
              ? Image.network(imageUrl!, width: size, height: size, fit: BoxFit.cover)
              : Container(
                  width: size,
                  height: size,
                  color: AppColors.primary,
                  alignment: Alignment.center,
                  child: Text(
                    fallbackText.isNotEmpty ? fallbackText[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: AppColors.backgroundLight,
                      fontSize: size * 0.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ),
        if (isOnline)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: size * 0.24,
              height: size * 0.24,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

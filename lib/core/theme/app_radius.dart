// lib/core/theme/app_radius.dart
//
// Chattova's signature shape language: asymmetric, speech-bubble-inspired
// corners. One corner stays sharp to suggest direction — never uniform
// rounding, never a traditional message "tail". See design system §4.

import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  // Standard components (cards, inputs, buttons): sharp bottom-right corner.
  static const BorderRadius standard = BorderRadius.only(
    topLeft: Radius.circular(14),
    topRight: Radius.circular(14),
    bottomLeft: Radius.circular(14),
    bottomRight: Radius.circular(4),
  );

  // Mirrored variant, for elements that should "point" the other way.
  static const BorderRadius standardMirrored = BorderRadius.only(
    topLeft: Radius.circular(14),
    topRight: Radius.circular(14),
    bottomLeft: Radius.circular(4),
    bottomRight: Radius.circular(14),
  );

  // Message bubble I sent — sharp bottom-right, sits on the right side.
  static const BorderRadius sentBubble = BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(4),
  );

  // Message bubble I received — sharp bottom-left, sits on the left side.
  static const BorderRadius receivedBubble = BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(4),
    bottomRight: Radius.circular(20),
  );

  // Avatars: rounded-square, never a circle (design system §5).
  static const BorderRadius avatar = BorderRadius.all(Radius.circular(14));

  // Fully round — used ONLY for the floating send button (§14), not general UI.
  static const BorderRadius pill = BorderRadius.all(Radius.circular(999));
}

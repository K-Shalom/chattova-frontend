// lib/core/responsive/breakpoints.dart
//
// Chattova's responsive breakpoints (design system §29). Rather than just
// stretching the mobile UI, screens use these to switch to genuinely
// different layouts (e.g. bottom nav -> side rail, single-pane -> 3-pane).

import 'package:flutter/widgets.dart';

class Breakpoints {
  Breakpoints._();

  static const double tablet = 700;
  static const double desktop = 1024;

  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= desktop;
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet && MediaQuery.sizeOf(context).width < desktop;
  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < tablet;
}

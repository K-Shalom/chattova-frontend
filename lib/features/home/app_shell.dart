// lib/features/home/app_shell.dart
//
// The persistent navigation frame around Chats/Contacts/Calls/Settings.
// Wraps go_router's StatefulNavigationShell — each tab keeps its own state
// when you switch away and back, instead of rebuilding from scratch.
//
// Desktop (design system §8): a NavigationRail on the left.
// Mobile: a bottom navigation bar.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_colors.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    (icon: Icons.chat_bubble_outline_rounded, selectedIcon: Icons.chat_bubble_rounded, label: 'Chats'),
    (icon: Icons.people_outline_rounded, selectedIcon: Icons.people_rounded, label: 'Contacts'),
    (icon: Icons.call_outlined, selectedIcon: Icons.call_rounded, label: 'Calls'),
    (icon: Icons.settings_outlined, selectedIcon: Icons.settings_rounded, label: 'Settings'),
  ];

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Breakpoints.isDesktop(context)) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              selectedIconTheme: const IconThemeData(color: AppColors.primary),
              destinations: _destinations
                  .map((d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ))
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: AppColors.primary.withValues(alpha: 0.15),
        destinations: _destinations
            .map((d) => NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon, color: AppColors.primary),
                  label: d.label,
                ))
            .toList(),
      ),
    );
  }
}

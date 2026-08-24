// lib/features/chats/chats_screen.dart
//
// The Conversations screen (design system §11): Global/Local segmented
// toggle, search, conversation list. On desktop this sits in a 2-pane
// layout (list + active conversation); on mobile it's the full screen and
// tapping a conversation pushes a separate thread screen (not built yet).

import 'package:flutter/material.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/empty_state.dart';

enum ConversationMode { global, local }

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  ConversationMode _mode = ConversationMode.global;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);

    final listPanel = _ConversationListPanel(
      mode: _mode,
      onModeChanged: (mode) => setState(() => _mode = mode),
    );

    if (!isDesktop) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chats')),
        body: listPanel,
      );
    }

    // Desktop: conversation list on the left, active conversation on the right.
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 340, child: listPanel),
          const VerticalDivider(width: 1),
          const Expanded(
            child: EmptyState(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Select a conversation',
              subtitle: 'Choose a conversation from the list to start chatting.',
            ),
          ),
        ],
      ),
    );
  }
}

class _ConversationListPanel extends StatelessWidget {
  const _ConversationListPanel({required this.mode, required this.onModeChanged});

  final ConversationMode mode;
  final ValueChanged<ConversationMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: _ModeToggle(mode: mode, onChanged: onModeChanged),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search conversations',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: mode == ConversationMode.global
              ? const EmptyState(
                  icon: Icons.forum_outlined,
                  title: 'Start a conversation',
                  subtitle: 'Search for people by username to begin chatting.',
                )
              : const EmptyState(
                  icon: Icons.wifi_tethering_rounded,
                  title: 'No nearby Chattova users yet',
                  subtitle: 'Local mode works even without an internet connection.',
                ),
        ),
      ],
    );
  }
}

// The "Global / Local" segmented pill control — Chattova's own take on a
// segmented control rather than a default Material SegmentedButton, so it
// carries the brand's pill shape consistently (design system §11).
class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.mode, required this.onChanged});

  final ConversationMode mode;
  final ValueChanged<ConversationMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : const Color(0xFFF2EDE9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          _ModeSegment(
            label: 'Global',
            selected: mode == ConversationMode.global,
            onTap: () => onChanged(ConversationMode.global),
          ),
          _ModeSegment(
            label: 'Local',
            selected: mode == ConversationMode.local,
            onTap: () => onChanged(ConversationMode.local),
          ),
        ],
      ),
    );
  }
}

class _ModeSegment extends StatelessWidget {
  const _ModeSegment({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = selected
        ? AppColors.backgroundLight
        : Theme.of(context).colorScheme.onSurface;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

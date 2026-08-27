// lib/features/chats/chats_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/conversation.dart';
import '../../shared/widgets/chattova_avatar.dart';
import '../../shared/widgets/empty_state.dart';
import 'conversations_controller.dart';
import 'new_chat_sheet.dart';

enum ConversationMode { global, local }

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => showNewChatSheet(context),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.edit_outlined, color: Colors.white),
        ),
      );
    }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewChatSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.edit_outlined, color: Colors.white),
      ),
    );
  }
}

class _ConversationListPanel extends ConsumerWidget {
  const _ConversationListPanel({required this.mode, required this.onModeChanged});

  final ConversationMode mode;
  final ValueChanged<ConversationMode> onModeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsControllerProvider);

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
          child: mode == ConversationMode.local
              ? const EmptyState(
                  icon: Icons.wifi_tethering_rounded,
                  title: 'No nearby Chattova users yet',
                  subtitle: 'Local mode works even without an internet connection.',
                )
              : conversationsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                  error: (error, stack) => EmptyState(
                    icon: Icons.error_outline_rounded,
                    title: 'Could not load conversations',
                    subtitle: error.toString(),
                  ),
                  data: (conversations) {
                    if (conversations.isEmpty) {
                      return const EmptyState(
                        icon: Icons.forum_outlined,
                        title: 'Start a conversation',
                        subtitle: 'Tap the pencil button to search for people by username.',
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () => ref.read(conversationsControllerProvider.notifier).refresh(),
                      child: ListView.builder(
                        itemCount: conversations.length,
                        itemBuilder: (context, index) => _ConversationTile(conversation: conversations[index]),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final title = conversation.type == 'group' ? (conversation.name ?? 'Group') : 'Direct message';

    return ListTile(
      leading: ChattovaAvatar(fallbackText: title, imageUrl: conversation.avatarUrl, size: 48),
      title: Text(title),
      subtitle: const Text('Tap to open (chat thread coming soon)'),
      onTap: () {
        // The chat thread screen isn't built yet — nothing to navigate to.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chat thread screen is coming soon.')),
        );
      },
    );
  }
}

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
          _ModeSegment(label: 'Global', selected: mode == ConversationMode.global, onTap: () => onChanged(ConversationMode.global)),
          _ModeSegment(label: 'Local', selected: mode == ConversationMode.local, onTap: () => onChanged(ConversationMode.local)),
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
    final textColor = selected ? AppColors.backgroundLight : Theme.of(context).colorScheme.onSurface;

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
          child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor)),
        ),
      ),
    );
  }
}

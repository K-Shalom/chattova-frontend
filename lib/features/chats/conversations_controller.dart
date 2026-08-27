// lib/features/chats/conversations_controller.dart
//
// Loads the signed-in user's conversation list and exposes a refresh()
// method (pull-to-refresh, or after starting a new chat). AsyncNotifier
// wraps loading/error/data states automatically — the screen just does
// `.when(loading: ..., error: ..., data: ...)`.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/conversation.dart';

class ConversationsController extends AsyncNotifier<List<Conversation>> {
  @override
  Future<List<Conversation>> build() async {
    final repository = ref.read(conversationsRepositoryProvider);
    return repository.listMine();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(conversationsRepositoryProvider).listMine());
  }
}

final conversationsControllerProvider =
    AsyncNotifierProvider<ConversationsController, List<Conversation>>(ConversationsController.new);

// lib/data/repositories/conversations_repository.dart

import '../../domain/models/conversation.dart';
import '../datasources/conversations_api.dart';

class ConversationsRepository {
  ConversationsRepository(this._api);

  final ConversationsApi _api;

  Future<List<Conversation>> listMine() async {
    final data = await _api.listMine();
    return data.map(Conversation.fromJson).toList();
  }

  Future<Conversation> createDirect(String otherUserId) async {
    final data = await _api.createDirect(otherUserId);
    return Conversation.fromJson(data);
  }
}

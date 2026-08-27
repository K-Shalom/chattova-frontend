// lib/domain/models/conversation.dart
//
// Matches the shape returned by GET /conversations and POST /conversations/direct
// (see backend modules/conversations/dto.js).

class Conversation {
  const Conversation({
    required this.id,
    required this.type,
    this.name,
    this.avatarUrl,
    this.lastMessageAt,
    required this.createdAt,
  });

  final String id;
  final String type; // 'direct' or 'group'
  final String? name; // null for direct conversations
  final String? avatarUrl;
  final DateTime? lastMessageAt;
  final DateTime createdAt;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      lastMessageAt: json['lastMessageAt'] != null ? DateTime.tryParse(json['lastMessageAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

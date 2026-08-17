// lib/domain/models/chattova_user.dart
//
// Represents a user as the app understands them — shaped to match exactly
// what the backend's /auth and /users endpoints return (see backend
// modules/auth/dto.js and modules/users/dto.js).

class ChattovaUser {
  const ChattovaUser({
    required this.id,
    required this.username,
    required this.displayName,
    required this.email,
    this.avatarUrl,
    this.bio,
    this.statusMessage,
    required this.isVerified,
  });

  final String id;
  final String username;
  final String displayName;
  final String email;
  final String? avatarUrl;
  final String? bio;
  final String? statusMessage;
  final bool isVerified;

  factory ChattovaUser.fromJson(Map<String, dynamic> json) {
    return ChattovaUser(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String? ?? json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      statusMessage: json['statusMessage'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }
}

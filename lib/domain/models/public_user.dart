// lib/domain/models/public_user.dart
//
// Matches backend modules/users/dto.js -> toPublicProfile (someone else's
// profile — never includes email/phone, unlike ChattovaUser which is "me").

class PublicUser {
  const PublicUser({
    required this.id,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.bio,
    this.statusMessage,
  });

  final String id;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final String? bio;
  final String? statusMessage;

  factory PublicUser.fromJson(Map<String, dynamic> json) {
    return PublicUser(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String? ?? json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      statusMessage: json['statusMessage'] as String?,
    );
  }
}

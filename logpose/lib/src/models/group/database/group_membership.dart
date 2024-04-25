import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMembership {
  const GroupMembership({
    required this.userId,
    required this.username,
    this.userDescription,
    required this.role,
    required this.groupId,
    this.updatedAt,
    required this.joinedAt,
  });

  factory GroupMembership.fromMap(Map<String, dynamic> data) {
    final userId = data['user_id'] as String;
    final username = data['username'] as String;
    final userDescription = data['user_description'] as String?;
    final role = data['role'] as String;
    final groupId = data['group_id'] as String;
    final updatedAt = data['updated_at'] as Timestamp?;
    final joinedAt = data['created_at'] as Timestamp;

    return GroupMembership(
      userId: userId,
      username: username,
      userDescription: userDescription,
      role: role,
      groupId: groupId,
      updatedAt: updatedAt,
      joinedAt: joinedAt,
    );
  }

  final String userId;
  final String username;
  final String? userDescription;
  final String role;
  final String groupId;
  final Timestamp? updatedAt;
  final Timestamp joinedAt;
}

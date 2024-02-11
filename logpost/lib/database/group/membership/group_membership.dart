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

  factory GroupMembership.fromMap(Map<String, dynamic> groupMembershipDocRef) {
    final userId = groupMembershipDocRef['user_id'] as String;
    final username = groupMembershipDocRef['username'] as String;
    final userDescription =
        groupMembershipDocRef['user_description'] as String?;
    final role = groupMembershipDocRef['role'] as String;
    final groupId = groupMembershipDocRef['group_id'] as String;
    final updatedAt = groupMembershipDocRef['updated_at'] as Timestamp?;
    final joinedAt = groupMembershipDocRef['created_at'] as Timestamp;

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

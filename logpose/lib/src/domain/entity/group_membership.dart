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

  final String userId;
  final String username;
  final String? userDescription;
  final String role;
  final String groupId;
  final Timestamp? updatedAt;
  final Timestamp joinedAt;
}

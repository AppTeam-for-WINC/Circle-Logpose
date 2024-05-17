import 'package:cloud_firestore/cloud_firestore.dart';

class GroupInvitation {
  const GroupInvitation({
    required this.groupId,
    required this.invitationLink,
    required this.expiresAt,
    required this.createdAt,
  });

  factory GroupInvitation.fromMap(Map<String, dynamic> data) {
    return GroupInvitation(
      groupId: data['group_id'] as String,
      invitationLink: data['invitation_link'] as String,
      expiresAt: data['expires_at'] as Timestamp,
      createdAt: data['created_at'] as Timestamp,
    );
  }

  final String groupId;
  final String invitationLink;
  final Timestamp expiresAt;
  final Timestamp createdAt;
}

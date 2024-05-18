import 'package:cloud_firestore/cloud_firestore.dart';

class GroupInvitationModel {
  const GroupInvitationModel({
    required this.groupId,
    required this.invitationLink,
    required this.expiresAt,
    required this.createdAt,
  });

  factory GroupInvitationModel.fromMap(Map<String, dynamic> data) {
    return GroupInvitationModel(
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

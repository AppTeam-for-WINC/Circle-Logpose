import 'package:cloud_firestore/cloud_firestore.dart';

class GroupInvitation {
  const GroupInvitation({
    required this.groupId,
    required this.invitationLink,
    required this.expiresAt,
    required this.createdAt,
  });

  final String groupId;

  final String invitationLink;

  final Timestamp expiresAt;
  
  final Timestamp createdAt;
}

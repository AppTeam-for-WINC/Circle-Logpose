class GroupMembership {
  GroupMembership({
    this.documentId,
    required this.groupId,
    required this.userId,
  });

  final String? documentId;
  final String groupId;
  final String userId;
}

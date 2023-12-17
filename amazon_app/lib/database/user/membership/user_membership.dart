class UserMembership {
  const UserMembership({
    this.documentId,
    required this.userId,
    required this.groupId,
    this.createdAt,
  });

  final String? documentId;
  final String userId;
  final String groupId;
  final DateTime? createdAt;
}

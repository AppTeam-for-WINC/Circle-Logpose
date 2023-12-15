class Group {
  Group({
    this.documentId,
    required this.name,
    required this.image,
    this.membershipKey,
    this.adminKey,
    this.createdAt,
  });

  ///document ID(primary)
  final String? documentId;

  ///name
  final String name;

  ///image
  final String image;

  ///memberkey
  final String? membershipKey;

  ///adminKey
  final String? adminKey;

  ///created time
  final DateTime? createdAt;
}

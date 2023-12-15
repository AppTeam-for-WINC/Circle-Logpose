class UserDB {
  UserDB({
    required this.documentId,
    this.name,
    this.image,
    required this.email,
  });

  final String documentId;
  final String? name;
  final String? image;
  final String email;
}

class UserProfile {
  const UserProfile({
    required this.docId,
    this.userId,
    this.name,
    this.image,
    required this.email,
  });

  final String docId;
  final String? userId;
  final String? name;
  final String? image;
  final String email;
}

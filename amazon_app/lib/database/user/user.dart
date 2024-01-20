import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  const UserProfile({
    required this.accountId,
    required this.name,
    required this.image,
    this.description,
    this.updatedAt,
    required this.createdAt,
  });

  final String accountId;
  final String name;
  final String image;
  final String? description;
  final Timestamp? updatedAt;
  final Timestamp createdAt;
}

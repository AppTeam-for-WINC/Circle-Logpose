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

  factory UserProfile.fromMap(Map<String, dynamic> userRef) {
    var accountId = userRef['account_id'];
    if (accountId is! String) {
      accountId = accountId.toString();
    }

    var name = userRef['name'];
    if (name is! String) {
      name = name.toString();
    }

    var image = userRef['image'];
    if (image is! String) {
      image = image.toString();
    }

    var description = userRef['description'];
    description = description as String?;

    var updatedAt = userRef['updated_at'];
    updatedAt = updatedAt as Timestamp?;

    var createdAt = userRef['created_at'];
    if (createdAt is! Timestamp) {
      createdAt = createdAt as Timestamp;
    }

    return UserProfile(
      accountId: accountId,
      name: name,
      image: image,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  final String accountId;
  final String name;
  final String image;
  final String? description;
  final Timestamp? updatedAt;
  final Timestamp createdAt;
}

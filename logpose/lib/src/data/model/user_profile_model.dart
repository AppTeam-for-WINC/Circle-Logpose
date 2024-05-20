import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  const UserProfileModel({
    required this.accountId,
    required this.name,
    required this.image,
    this.description,
    this.updatedAt,
    required this.createdAt,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> data) {
    var accountId = data['account_id'];
    if (accountId is! String) {
      accountId = accountId.toString();
    }

    var name = data['name'];
    if (name is! String) {
      name = name.toString();
    }

    var image = data['image'];
    if (image is! String) {
      image = image.toString();
    }

    var description = data['description'];
    description = description as String?;

    var updatedAt = data['updated_at'];
    updatedAt = updatedAt as Timestamp?;

    var createdAt = data['created_at'];
    if (createdAt is! Timestamp) {
      createdAt = createdAt as Timestamp;
    }

    return UserProfileModel(
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

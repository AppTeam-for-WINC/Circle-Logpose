import 'package:cloud_firestore/cloud_firestore.dart';

class GroupProfileModel {
  const GroupProfileModel({
    required this.name,
    this.description,
    required this.image,
    this.updatedAt,
    required this.createdAt,
  });

  factory GroupProfileModel.fromMap(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final description = data['description'] as String?;
    final image = data['image'] as String;
    final updatedAt = data['updated_at'] as Timestamp?;
    final createdAt = data['created_at'] as Timestamp;

    return GroupProfileModel(
      name: name,
      image: image,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  final String name;

  final String? description;

  final String image;

  final Timestamp? updatedAt;

  final Timestamp createdAt;
}

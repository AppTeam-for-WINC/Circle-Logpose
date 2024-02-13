import 'package:cloud_firestore/cloud_firestore.dart';

class GroupProfile {
  const GroupProfile({
    required this.name,
    this.description,
    required this.image,
    this.updatedAt,
    required this.createdAt,
  });

  factory GroupProfile.fromMap(Map<String, dynamic> groupRef) {
    final name = groupRef['name'] as String;
    final description = groupRef['descrption'] as String?;
    final image = groupRef['image'] as String;
    final updatedAt = groupRef['updated_at'] as Timestamp?;
    final createdAt = groupRef['created_at'] as Timestamp;
    
    return GroupProfile(
      name: name,
      image: image,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  /// name
  final String name;

  /// description
  final String? description;

  /// image
  final String image;

  /// updated_at
  final Timestamp? updatedAt;

  /// created time
  final Timestamp createdAt;
}

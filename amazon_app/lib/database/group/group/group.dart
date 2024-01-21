import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  const Group({
    required this.name,
    this.description,
    required this.image,
    this.updatedAt,
    required this.createdAt,
  });

  ///name
  final String name;

  ///description
  final String? description;

  ///image
  final String image;

  ///updated_at
  final Timestamp? updatedAt;

  ///created time
  final Timestamp createdAt;
}

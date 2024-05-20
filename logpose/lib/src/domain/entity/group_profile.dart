import 'package:cloud_firestore/cloud_firestore.dart';

class GroupProfile {
  const GroupProfile({
    required this.name,
    this.description,
    required this.image,
    this.updatedAt,
    required this.createdAt,
  });
  
  final String name;

  final String? description;

  final String image;

  final Timestamp? updatedAt;

  final Timestamp createdAt;

  GroupProfile copyWith({
    String? name,
    String? description,
    String? image,
    Timestamp? updatedAt,
  }) {
    return GroupProfile(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt,
    );
  }
}

// <- Example, extension function. ->
// extension CopyWith on GroupProfile {
//   GroupProfile copyWith({
//     String? name,
//     String? description,
//     String? image,
//     Timestamp? updatedAt,
//     Timestamp? createdAt,
//   }) {
//     return GroupProfile(
//       name: name ?? this.name,
//       description: description ?? this.description,
//       image: image ?? this.image,
//       updatedAt: updatedAt ?? this.updatedAt,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }
// < -- >

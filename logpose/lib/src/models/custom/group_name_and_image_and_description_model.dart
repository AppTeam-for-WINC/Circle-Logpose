import 'dart:io';

class GroupNameAndImageAndDescription {
  GroupNameAndImageAndDescription({
    required this.groupName,
    required this.image,
    required this.description,
  });

  final String groupName;
  final File? image;
  final String? description;
}

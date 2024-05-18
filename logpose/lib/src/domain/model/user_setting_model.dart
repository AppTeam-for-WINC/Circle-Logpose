import 'dart:io';

class UserSettingParams {
  UserSettingParams({
    required this.name,
    required this.image,
    required this.description,
  });

  final String name;
  final File? image;
  final String? description;
}

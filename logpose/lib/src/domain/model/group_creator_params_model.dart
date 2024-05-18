import 'dart:io';

import '../entity/user_profile.dart';

class GroupCreatorParams {
  GroupCreatorParams({
    required this.groupName,
    required this.image,
    required this.description,
    required this.memberList,
  });

  final String groupName;
  final File? image;
  final String? description;
  final List<UserProfile> memberList;
}

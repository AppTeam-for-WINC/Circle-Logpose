import 'dart:io';

import '../database/user/user.dart';

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

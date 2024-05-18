import 'dart:io';

import '../entity/user_profile.dart';

class GroupSettingParams {
  GroupSettingParams({
    required this.groupId,
    required this.groupName,
    required this.image,
    required this.description,
    required this.memberList,
  });

  final String groupId;
  final String groupName;
  final File? image;
  final String? description;
  final List<UserProfile> memberList;
}

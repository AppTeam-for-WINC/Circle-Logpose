import 'dart:io';

import '../../data/models/user.dart';

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

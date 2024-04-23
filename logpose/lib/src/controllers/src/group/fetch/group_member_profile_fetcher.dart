import 'package:flutter/widgets.dart';

import '../../../../models/user/user.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

class GroupMemberProfileFetcher {
    GroupMemberProfileFetcher._internal();
  static final GroupMemberProfileFetcher _instance =
      GroupMemberProfileFetcher._internal();
  static GroupMemberProfileFetcher get instance => _instance;


static Future<String> fetchGroupIdWithScheduleId(String scheduleId) async {
  final groupId = await GroupScheduleController.readGroupId(scheduleId);
  if (groupId == null) {
    throw Exception('Group ID is null');
  }
  return groupId;
}

static Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
  String scheduleId,
  List<String?> userIdList,
) async {
  return Future.wait(
    userIdList.where((id) => id != null).map((userId) {
      return _fetchUserProfilesNotAbsent(scheduleId, userId!);
    }).toList(),
  );
}

static Future<UserProfile?> _fetchUserProfilesNotAbsent(
  String scheduleId,
  String userId,
) async {
  try {
    final responsedUserIdList = await _fetchUserIdList(
      scheduleId,
      userId,
    );
    for (final responsedUserId in responsedUserIdList) {
      if (responsedUserId != null) {
        final userProfile = await UserController.read(responsedUserId);
        return userProfile;
      }
    }
  } on Exception catch (e) {
    debugPrint('Error fetching profiles: $e');
  }
  return null;
}

static Future<List<String?>> _fetchUserIdList(
  String scheduleId,
  String userId,
) async {
  return GroupMemberScheduleController.readAllUserDocIdByTerm(
    scheduleId,
    userId,
  );
}
}

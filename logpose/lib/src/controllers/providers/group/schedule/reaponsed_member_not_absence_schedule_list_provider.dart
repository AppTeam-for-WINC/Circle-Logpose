import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';

import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

/// Group membership user list controller under condition not absence.
final watchGroupMembershipProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final groupId = await _readGroupIdWithScheduleId(scheduleId);
  final userDocIdStream =
      GroupMembershipController.watchAllUserDocIdWithGroupId(groupId);

  await for (final userIdList in userDocIdStream) {
    final userProfiles = await _readUserProfilesNotAbsentList(
      scheduleId: scheduleId,
      userIdList: userIdList,
    );
    yield userProfiles;
  }
});

Future<String> _readGroupIdWithScheduleId(String scheduleId) async {
  final groupId = await GroupScheduleController.readGroupId(scheduleId);
  if (groupId == null) {
    throw Exception('Group ID is null');
  }
  return groupId;
}

Future<List<UserProfile>> _readUserProfilesNotAbsentList({
  required String scheduleId,
  required List<String?> userIdList,
}) async {
  final future = userIdList.map((userId) {
    if (userId == null) {
      throw Exception('User ID is null');
    }
    return  _readUserProfilesNotAbsent(scheduleId: scheduleId, userId: userId);
  });
  final profiles = await Future.wait(future);
  return profiles.whereType<UserProfile>().toList();
}

Future<UserProfile?> _readUserProfilesNotAbsent({
  required String scheduleId,
  required String userId,
}) async {
  final responsedUserIdList = await _readUserIdList(
    scheduleId: scheduleId,
    userId: userId,
  );
  for (final responsedUserId in responsedUserIdList) {
    if (responsedUserId != null) {
      final userProfile =  await UserController.read(responsedUserId);
      return userProfile;
    }
  }
  return null;
}

Future<List<String?>> _readUserIdList({
  required String scheduleId,
  required String userId,
}) async {
  final responsedUserIdList =
      await GroupMemberScheduleController.readAllUserDocIdByTerm(
    scheduleId,
    userId,
  );

  return responsedUserIdList;
}

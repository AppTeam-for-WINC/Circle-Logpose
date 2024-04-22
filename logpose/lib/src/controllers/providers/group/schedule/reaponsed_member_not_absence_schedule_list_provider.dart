import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';

import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

/// Group membership user list controller under condition not absence.
final watchGroupMembershipProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final groupId = await _fetchGroupIdWithScheduleId(scheduleId);

  yield* GroupMembershipController.watchAllUserDocIdWithGroupId(groupId)
      .asyncMap(
    (userIdList) => _fetchUserProfilesNotAbsentList(scheduleId, userIdList),
  );
});

Future<String> _fetchGroupIdWithScheduleId(String scheduleId) async {
  final groupId = await GroupScheduleController.readGroupId(scheduleId);
  if (groupId == null) {
    throw Exception('Group ID is null');
  }
  return groupId;
}

Future<List<UserProfile?>> _fetchUserProfilesNotAbsentList(
  String scheduleId,
  List<String?> userIdList,
) async {
  return Future.wait(
    userIdList.where((id) => id != null).map((userId) {
      return _fetchUserProfilesNotAbsent(scheduleId, userId!);
    }).toList(),
  );
}

Future<UserProfile?> _fetchUserProfilesNotAbsent(
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

Future<List<String?>> _fetchUserIdList(
  String scheduleId,
  String userId,
) async {
  return GroupMemberScheduleController.readAllUserDocIdByTerm(
    scheduleId,
    userId,
  );
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../database/group/membership/group_membership_controller.dart';
import '../../../../../database/group/schedule/member_schedule/member_schedule.dart';
import '../../../../../database/group/schedule/member_schedule/member_schedule_controller.dart';
import '../../../../../database/group/schedule/schedule/schedule_controller.dart';
import '../../../../../database/user/user.dart';
import '../../../../../database/user/user_controller.dart';

/// Group membership users controller under condition not absence.
final groupMembershipProfileListNotAbsenceProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, scheduleId) async* {
  final groupId = await GroupScheduleController.readGroupId(scheduleId);
  if (groupId == null) {
    return;
  }
  final userDocIdStream =
      GroupMembershipController.watchAllUserDocIdWithGroupIdStream(groupId);

  await for (final userDocIdList in userDocIdStream) {
    final userProfileList = <UserProfile>[];

    for (final userDocId in userDocIdList) {
      if (userDocId == null) {
        continue;
      }

      final responsedUserIdList =
          await GroupMemberScheduleController.readAllUserDocIdByTerm(
        scheduleId,
        userDocId,
      );

      for (final responsedUserId in responsedUserIdList) {
        if (responsedUserId == null) {
          continue;
        }

        final userProfile = await UserController.read(userDocId);
        userProfileList.add(userProfile);
      }
    }
    yield userProfileList;
  }
});

final watchGroupMemberScheduleProvider =
    StreamProvider.family<List<GroupMemberSchedule?>, String>(
        (ref, scheduleId) async* {
  final groupId = await GroupScheduleController.readGroupId(scheduleId);
  if (groupId == null) {
    return;
  }
  final userDocIdStream =
      GroupMembershipController.watchAllUserDocIdWithGroupIdStream(groupId);

  await for (final userDocIdList in userDocIdStream) {
    final groupMemberScheduleList = <GroupMemberSchedule>[];

    for (final userDocId in userDocIdList) {
      if (userDocId == null) {
        continue;
      }

      final responsedMemberScheduleList =
          await GroupMemberScheduleController.readAllMemberScheduleByTerm(
        scheduleId,
        userDocId,
      );

      for (final responsedMemberSchedule in responsedMemberScheduleList) {
        if (responsedMemberSchedule == null) {
          continue;
        }

        groupMemberScheduleList.add(responsedMemberSchedule);
      }
    }
    yield groupMemberScheduleList;
  }
});

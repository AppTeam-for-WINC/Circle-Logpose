import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';

import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

/// Group membership user list controller under condition not absence.
final watchGroupMembershipProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final groupId = await GroupScheduleController.readGroupId(scheduleId);
  if (groupId == null) {
    return;
  }
  final userDocIdStream =
      GroupMembershipController.watchAllUserDocIdWithGroupIdStream(groupId);

  await for (final userDocIdList in userDocIdStream) {
    final userProfileList = <UserProfile?>[];

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

        final userProfile = await UserController.read(responsedUserId);
        userProfileList.add(userProfile);
      }
    }

    yield userProfileList;
  }
});

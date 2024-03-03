import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/database/member_schedule.dart';
import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

final watchResponsedGroupMemberScheduleProvider = StreamProvider.family
    .autoDispose<GroupMemberSchedule?, ({String scheduleId, String accountId})>(
        (ref, args) async* {
  final groupId = await GroupScheduleController.readGroupId(args.scheduleId);
  if (groupId == null) {
    return;
  }
  final userDocIdStream =
      GroupMembershipController.watchAllUserDocIdWithGroupId(groupId);
  final currentUserDocId =
      await UserController.readUserDocIdWithAccountId(args.accountId);
  await for (final userDocIdList in userDocIdStream) {
    for (final userDocId in userDocIdList) {
      if (userDocId != currentUserDocId) {
        continue;
      }

      final responsedMemberScheduleList =
          await GroupMemberScheduleController.readAllMemberScheduleByTerm(
        args.scheduleId,
        currentUserDocId,
      );

      for (final responsedMemberSchedule in responsedMemberScheduleList) {
        if (responsedMemberSchedule == null) {
          continue;
        }

        yield responsedMemberSchedule;
      }
    }
  }
});

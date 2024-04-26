import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/database/group/member_schedule.dart';

import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

/// Watch responsed group member's schedule.
final watchResponsedGroupMemberScheduleProvider = StreamProvider.family
    .autoDispose<GroupMemberSchedule?, ({String scheduleId, String accountId})>(
        (ref, args) async* {
  try {
    final userDocId =
        await UserController.readUserDocIdWithAccountId(args.accountId);

    yield await GroupMemberScheduleController.readGroupMemberSchedule(
      userDocId: userDocId,
      scheduleId: args.scheduleId,
    );
  } on Exception catch (e) {
    debugPrint('Failed to fetch Group member schedule. $e');
    yield null;
  }
});
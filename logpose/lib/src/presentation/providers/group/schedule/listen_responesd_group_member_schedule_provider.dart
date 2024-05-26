import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/group_member_schedule.dart';

import '../../../controllers/group_member_schedule/group_member_schedule_management_controller.dart';

final listenResponsedGroupMemberScheduleProvider = StreamProvider.family
    .autoDispose<GroupMemberSchedule?, ({String scheduleId, String accountId})>(
        (ref, args) async* {
  final memberScheduleController =
      ref.read(groupMemberScheduleManagementControllerProvider);
  yield* memberScheduleController.listenResponsedGroupMemberSchedule(
    args.scheduleId,
    args.accountId,
  );
});

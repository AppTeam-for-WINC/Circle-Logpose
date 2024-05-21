import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/facade/group_member_schedule_facade.dart';

import '../../../entity/group_member_schedule.dart';

final listenResponsedGroupMemberScheduleProvider = StreamProvider.family
    .autoDispose<GroupMemberSchedule?, ({String scheduleId, String accountId})>(
        (ref, args) async* {
  final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
  yield* memberScheduleFacade.listenResponsedGroupMemberSchedule(
    args.scheduleId,
    args.accountId,
  );
});

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entity/group_member_schedule.dart';

import '../../../usecase/facade/group_member_schedule_facade.dart';
import '../../../usecase/facade/user_service_facade.dart';

/// Watch responsed group member's schedule.
final watchResponsedGroupMemberScheduleProvider = StreamProvider.family
    .autoDispose<GroupMemberSchedule?, ({String scheduleId, String accountId})>(
        (ref, args) async* {
  try {
    final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    final userDocId =
        await userServiceFacade.fetchUserDocIdWithAccountId(args.accountId);

    yield await memberScheduleFacade.fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId,
      args.scheduleId,
    );
  } on Exception catch (e) {
    debugPrint('Failed to fetch Group member schedule. $e');
    yield null;
  }
});

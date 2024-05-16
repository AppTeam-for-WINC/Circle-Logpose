import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/database/group/member_schedule.dart';

import '../../../usecase/group_member_schedule_use_case.dart';
import '../../../usecase/user_use_case.dart';

/// Watch responsed group member's schedule.
final watchResponsedGroupMemberScheduleProvider = StreamProvider.family
    .autoDispose<GroupMemberSchedule?, ({String scheduleId, String accountId})>(
        (ref, args) async* {
  try {
    final userUseCase = ref.read(userUseCaseProvider);
    final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);

    final userDocId =
        await userUseCase.fetchUserDocIdWithAccountId(args.accountId);

    yield await memberScheduleUseCase
        .fetchMemberScheduleWithUserIdAndScheduleId(userDocId, args.scheduleId);
  } on Exception catch (e) {
    debugPrint('Failed to fetch Group member schedule. $e');
    yield null;
  }
});

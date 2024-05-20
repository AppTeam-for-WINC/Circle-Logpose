import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/group_member_schedule.dart';

import '../usecase_user/user_id_use_case.dart';
import 'group_member_schedule_id_use_case.dart';
import 'group_member_schedule_use_case.dart';

final groupMemberScheduleListenResponsedUseCaseProvider =
    Provider<GroupMemberScheduleListenResponsedUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final memberScheduleIdUseCase =
      ref.read(groupMemberScheduleIdUseCaseProvider);
  final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);

  return GroupMemberScheduleListenResponsedUseCase(
    ref: ref,
    userIdUseCase: userIdUseCase,
    memberScheduleIdUseCase: memberScheduleIdUseCase,
    memberScheduleUseCase: memberScheduleUseCase,
  );
});

class GroupMemberScheduleListenResponsedUseCase {
  const GroupMemberScheduleListenResponsedUseCase({
    required this.ref,
    required this.userIdUseCase,
    required this.memberScheduleIdUseCase,
    required this.memberScheduleUseCase,
  });

  final Ref ref;
  final UserIdUseCase userIdUseCase;
  final GroupMemberScheduleIdUseCase memberScheduleIdUseCase;
  final GroupMemberScheduleUseCase memberScheduleUseCase;

  Stream<GroupMemberSchedule?> listenResponsedGroupMemberSchedule(
    String scheduleId,
    String accountId,
  ) async* {
    try {
      final userDocId = await _fetchUserDocId(accountId);

      yield await _fetchMemberSchedule(userDocId, scheduleId);
    } on Exception catch (e) {
      debugPrint('Failed to fetch Group member schedule. $e');
      yield null;
    }
  }

  Future<String> _fetchUserDocId(String accountId) async {
    return userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }

  Future<GroupMemberSchedule?> _fetchMemberSchedule(
    String userDocId,
    String scheduleId,
  ) async {
    return memberScheduleUseCase.fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId,
      scheduleId,
    );
  }
}

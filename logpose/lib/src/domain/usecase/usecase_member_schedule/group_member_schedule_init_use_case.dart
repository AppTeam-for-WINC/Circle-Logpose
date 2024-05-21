import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/group_member_schedule.dart';

import '../../interface/auth/i_auth_user_id_use_case.dart';
import '../../interface/group_member_schedule/i_group_member_schedule_id_use_case.dart';
import '../../interface/group_member_schedule/i_group_member_schedule_init_use_case.dart';
import '../../interface/group_member_schedule/i_group_member_schedule_use_case.dart';
import '../../interface/group_schedule/i_group_schedule_use_case.dart';

import '../usecase_auth/user_id_use_case.dart';
import '../usecase_group_schedule/group_schedule_use_case.dart';
import 'group_member_schedule_id_use_case.dart';
import 'group_member_schedule_use_case.dart';

final groupMemberScheduleInitUseCaseProvider =
    Provider<IGroupMemberScheduleInitUseCase>((ref) {
  final authIdUseCase = ref.read(authUserIdUseCaseProvider);
  final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);
  final memberScheduleIdUseCase =
      ref.read(groupMemberScheduleIdUseCaseProvider);
  final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);

  return GroupMemberScheduleInitUseCase(
    ref: ref,
    authIdUseCase: authIdUseCase,
    groupScheduleUseCase: groupScheduleUseCase,
    memberScheduleIdUseCase: memberScheduleIdUseCase,
    memberScheduleUseCase: memberScheduleUseCase,
  );
});

class GroupMemberScheduleInitUseCase
    implements IGroupMemberScheduleInitUseCase {
  const GroupMemberScheduleInitUseCase({
    required this.ref,
    required this.authIdUseCase,
    required this.groupScheduleUseCase,
    required this.memberScheduleIdUseCase,
    required this.memberScheduleUseCase,
  });

  final Ref ref;
  final IAuthUserIdUseCase authIdUseCase;
  final IGroupScheduleUseCase groupScheduleUseCase;
  final IGroupMemberScheduleIdUseCase memberScheduleIdUseCase;
  final IGroupMemberScheduleUseCase memberScheduleUseCase;

  @override
  Future<GroupMemberSchedule> initMemberSchedule(String groupScheduleId) async {
    try {
      return await _attemptToInitSchedule(groupScheduleId);
    } on Exception catch (e) {
      throw Exception('Error initializing member schedule $e');
    }
  }

  Future<GroupMemberSchedule> _attemptToInitSchedule(
    String groupScheduleId,
  ) async {
    final groupSchedule = await groupScheduleUseCase.fetchGroupSchedule(
      groupScheduleId,
    );
    final userDocId = await authIdUseCase.fetchCurrentUserId();
    final memberScheduleId =
        await memberScheduleIdUseCase.fetchMemberScheduleId(
      groupScheduleId,
      userDocId,
    );
    final memberSchedule =
        await memberScheduleUseCase.fetchMemberSchedule(memberScheduleId);

    return GroupMemberSchedule(
      scheduleId: memberScheduleId,
      userId: userDocId,
      startAt: memberSchedule.startAt ?? groupSchedule.startAt,
      endAt: memberSchedule.endAt ?? groupSchedule.endAt,
      attendance: memberSchedule.attendance,
      leaveEarly: memberSchedule.leaveEarly,
      lateness: memberSchedule.lateness,
      absence: memberSchedule.absence,
      createdAt: memberSchedule.createdAt,
    );
  }
}

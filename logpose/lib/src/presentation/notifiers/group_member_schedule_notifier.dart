import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/group_member_schedule.dart';

import '../../domain/usecase/facade/group_member_schedule_facade.dart';

final groupMemberScheduleNotifierProvider = StateNotifierProvider.family
    .autoDispose<_MemberScheduleNotifier, GroupMemberSchedule?, String>(
  _MemberScheduleNotifier.new,
);

class _MemberScheduleNotifier extends StateNotifier<GroupMemberSchedule?> {
  _MemberScheduleNotifier(this.ref, this.groupScheduleId)
      : _memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider),
        super(null) {
    _initSchedule();
  }

  final Ref ref;
  final String groupScheduleId;
  final GroupMemberScheduleFacade _memberScheduleFacade;

  Future<void> _initSchedule() async {
    state = await _memberScheduleFacade.initMemberSchedule(groupScheduleId);
  }

  Future<void> setStartAt(DateTime startAt) async {
    state = state!.copyWith(startAt: startAt);
  }

  Future<void> setEndAt(DateTime endAt) async {
    state = state!.copyWith(endAt: endAt);
  }

  Future<void> updateAttendance({required bool attendance}) async {
    state = state!.copyWith(
      attendance: !attendance,
      leaveEarly: false,
      lateness: false,
      absence: false,
    );
  }

  Future<void> updateLeaveEarly({required bool leaveEarly}) async {
    state = state!.copyWith(
      attendance: false,
      leaveEarly: !leaveEarly,
      lateness: false,
      absence: false,
    );
  }

  Future<void> updateLateness({required bool lateness}) async {
    state = state!.copyWith(
      attendance: false,
      leaveEarly: false,
      lateness: !lateness,
      absence: false,
    );
  }

  Future<void> updateAbsence({required bool absence}) async {
    state = state!.copyWith(
      attendance: false,
      leaveEarly: false,
      lateness: false,
      absence: !absence,
    );
  }
}

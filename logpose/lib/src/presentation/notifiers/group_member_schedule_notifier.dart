import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/group_member_schedule.dart';
import '../controllers/group_member_schedule/group_member_schedule_management_controller.dart';

final groupMemberScheduleNotifierProvider = StateNotifierProvider.family
    .autoDispose<_MemberScheduleNotifier, GroupMemberSchedule?, String>(
  _MemberScheduleNotifier.new,
);

class _MemberScheduleNotifier extends StateNotifier<GroupMemberSchedule?> {
  _MemberScheduleNotifier(this.ref, this.groupScheduleId)
      : _memberScheduleController =
            ref.read(groupMemberScheduleManagementControllerProvider),
        super(null) {
    _initSchedule();
  }

  final Ref ref;
  final String groupScheduleId;
  final GroupMemberScheduleManagementController _memberScheduleController;

  Future<void> _initSchedule() async {
    final schedule =
        await _memberScheduleController.initMemberSchedule(groupScheduleId);
    if (mounted) {
      state = schedule;
    }
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

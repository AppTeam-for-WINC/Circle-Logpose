import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/group_schedule.dart';
import '../../../../data/models/member_schedule.dart';

import '../../../../models/custom/schedule_response_params_model.dart';

import '../../../usecase/facade/group_member_schedule_facade.dart';
import '../../../usecase/facade/group_schedule_facade.dart';
import '../../../usecase/facade/user_service_facade.dart';
import '../../../usecase/usecase_member_schedule/group_member_schedule_id_use_case.dart';

final groupMemberScheduleProvider = StateNotifierProvider.family<
    _MemberScheduleNotifier, GroupMemberSchedule?, String>(
  _MemberScheduleNotifier.new,
);

class _MemberScheduleNotifier extends StateNotifier<GroupMemberSchedule?> {
  _MemberScheduleNotifier(this.ref, this.groupScheduleId)
      : groupScheduleFacade = ref.read(groupScheduleFacadeProvider),
        _memberScheduleIdUseCase=
            ref.read(groupMemberScheduleIdUseCaseProvider),
        _memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider),
        memberScheduleController = ref.read(groupMemberScheduleFacadeProvider),
        _userServiceFacade = ref.read(userServiceFacadeProvider),
        super(null) {
    initSchedule();
  }

  final StateNotifierProviderRef<_MemberScheduleNotifier, GroupMemberSchedule?>
      ref;
  final String groupScheduleId;
  final GroupScheduleFacade groupScheduleFacade;
  final GroupMemberScheduleIdUseCase _memberScheduleIdUseCase;
  final GroupMemberScheduleFacade _memberScheduleFacade;
  final GroupMemberScheduleFacade memberScheduleController;
  final UserServiceFacade _userServiceFacade;

  Future<void> initSchedule() async {
    try {
      await _attemptToInitSchedule();
    } on Exception catch (e) {
      throw Exception('Error initializing member schedule $e');
    }
  }

  Future<void> _attemptToInitSchedule() async {
    final groupSchedule = await _fetchGroupSchedule();
    final userDocId = await _fetchCurrentUserId();
    final memberScheduleDocId = await _fetchMemberScheduleId(userDocId);
    final memberSchedule = await _fetchMemberSchedule(memberScheduleDocId);

    state = GroupMemberSchedule(
      scheduleId: memberScheduleDocId,
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

  Future<GroupSchedule> _fetchGroupSchedule() async {
    return groupScheduleFacade.fetchGroupSchedule(groupScheduleId);
  }

  Future<String> _fetchCurrentUserId() async {
    return _userServiceFacade.fetchCurrentUserId();
  }

  Future<String> _fetchMemberScheduleId(String userDocId) async {
    return _memberScheduleIdUseCase.fetchMemberScheduleId(
      groupScheduleId,
      userDocId,
    );
  }

  Future<GroupMemberSchedule> _fetchMemberSchedule(
    String memberScheduleId,
  ) async {
    return _memberScheduleFacade.fetchMemberSchedule(memberScheduleId);
  }

  Future<void> setStartAt(DateTime startAt) async {
    state = state!.copyWith(startAt: startAt);
  }

  Future<void> setEndAt(DateTime endAt) async {
    state = state!.copyWith(endAt: endAt);
  }

  Future<void> updateStartAt(DateTime? startAt) async {
    await memberScheduleController.updateStartAt(state!.scheduleId, startAt);
  }

  Future<void> updateEndAt(DateTime? endAt) async {
    await memberScheduleController.updateEndAt(state!.scheduleId, endAt);
  }

  Future<void> updateAttendance({required bool attendance}) async {
    try {
      await _attemptToAttendance(attendance: attendance);
    } on Exception catch (e) {
      throw Exception('Failed to update attendance. $e');
    }
  }

  Future<void> _attemptToAttendance({required bool attendance}) async {
    final updatedState = state!.copyWith(
      attendance: !attendance,
      leaveEarly: false,
      lateness: false,
      absence: false,
    );

    await _updateResponse(
      ScheduleResponseParams(
        memberScheduleId: state!.scheduleId,
        attendance: !attendance,
        leaveEarly: false,
        lateness: false,
        absence: false,
      ),
    );

    state = updatedState;
  }

  Future<void> updateLeaveEarly({required bool leaveEarly}) async {
    try {
      await _attemptToLeaveEarly(leaveEarly: leaveEarly);
    } on Exception catch (e) {
      throw Exception('Failed to update leaveEarly. $e');
    }
  }

  Future<void> _attemptToLeaveEarly({required bool leaveEarly}) async {
    final updatedState = state!.copyWith(
      attendance: false,
      leaveEarly: !leaveEarly,
      lateness: false,
      absence: false,
    );

    await _updateResponse(
      ScheduleResponseParams(
        memberScheduleId: state!.scheduleId,
        attendance: false,
        leaveEarly: !leaveEarly,
        lateness: false,
        absence: false,
      ),
    );

    state = updatedState;
  }

  Future<void> updateLateness({required bool lateness}) async {
    try {
      await _attemptToLateness(lateness: lateness);
    } on Exception catch (e) {
      throw Exception('Failed to update lateness $e');
    }
  }

  Future<void> _attemptToLateness({required bool lateness}) async {
    final updatedState = state!.copyWith(
      attendance: false,
      leaveEarly: false,
      lateness: !lateness,
      absence: false,
    );

    await _updateResponse(
      ScheduleResponseParams(
        memberScheduleId: state!.scheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: !lateness,
        absence: false,
      ),
    );

    state = updatedState;
  }

  /// Update Group membership's schedule of absence.
  Future<void> updateAbsence({required bool absence}) async {
    try {
      await _attemptToAbsence(absence: absence);
    } on Exception catch (e) {
      throw Exception('Failed to update absence. $e');
    }
  }

  /// Update Group membership's schedule of absence.
  Future<void> _attemptToAbsence({required bool absence}) async {
    final updatedState = state!.copyWith(
      attendance: false,
      leaveEarly: false,
      lateness: false,
      absence: !absence,
    );

    await _updateResponse(
      ScheduleResponseParams(
        memberScheduleId: state!.scheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: false,
        absence: !absence,
      ),
    );

    state = updatedState;
  }

  Future<void> _updateResponse(ScheduleResponseParams scheduleParams) async {
    await memberScheduleController.updateResponse(scheduleParams);
  }
}

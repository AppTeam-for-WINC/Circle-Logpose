import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';

final groupMemberScheduleProvider = StateNotifierProvider.family<
    _UpdateMemberScheduleNotifier, _MemberScheduleViewer?, String>(
  (ref, groupScheduleId) => _UpdateMemberScheduleNotifier(groupScheduleId),
);

class _MemberScheduleViewer {
  _MemberScheduleViewer({
    this.attendance,
    this.leavingEarly,
    this.lateness,
    this.absence,
    this.startAt,
    this.endAt,
  });

  final bool? attendance;
  final bool? leavingEarly;
  final bool? lateness;
  final bool? absence;
  final DateTime? startAt;
  final DateTime? endAt;

  _MemberScheduleViewer copyWith({
    DateTime? startAt,
    DateTime? endAt,
    bool? attendance,
    bool? leavingEarly,
    bool? lateness,
    bool? absence,
  }) {
    return _MemberScheduleViewer(
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      attendance: attendance ?? this.attendance,
      leavingEarly: leavingEarly ?? this.leavingEarly,
      lateness: lateness ?? this.lateness,
      absence: absence ?? this.absence,
    );
  }
}

class _UpdateMemberScheduleNotifier
    extends StateNotifier<_MemberScheduleViewer?> {
  _UpdateMemberScheduleNotifier(String groupScheduleId)
      : super(_MemberScheduleViewer()) {
    _initSchedule(groupScheduleId);
  }

  Future<void> _initSchedule(String groupScheduleId) async {
    final groupSchedule = await GroupScheduleController.read(groupScheduleId);
    if (groupSchedule == null) {
      return;
    }

    final userDocId = await AuthController.getCurrentUserId();
    if (userDocId == null) {
      throw Exception('User not logged in.');
    }

    final memberScheduleId = await _readDocId(
      groupScheduleId,
      userDocId,
    );
    if (memberScheduleId == null) {
      return;
    }

    final memberSchedule =
        await GroupMemberScheduleController.read(memberScheduleId);
    if (memberSchedule == null) {
      return;
    }

    DateTime initStartAt;
    if (memberSchedule.startAt == null) {
      initStartAt = groupSchedule.startAt;
    } else {
      initStartAt = memberSchedule.startAt!;
    }
    DateTime initEndAt;
    if (memberSchedule.endAt == null) {
      initEndAt = groupSchedule.endAt;
    } else {
      initEndAt = memberSchedule.endAt!;
    }

    state = _MemberScheduleViewer(
      startAt: initStartAt,
      endAt: initEndAt,
      attendance: memberSchedule.attendance,
      leavingEarly: memberSchedule.leaveEarly,
      lateness: memberSchedule.lateness,
      absence: memberSchedule.absence,
    );
  }

  static Future<String?> _readDocId(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      return GroupMemberScheduleController.readDocIdWithScheduleIdAndUserId(
        scheduleId: scheduleId,
        userDocId: userDocId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Failed to read Doc ID. $e');
    }
  }

  void setStartAt(DateTime startAt) {
    state = state!.copyWith(startAt: startAt);
  }

  void setEndAt(DateTime endAt) {
    state = state!.copyWith(endAt: endAt);
  }

  void setAttendance({required bool attendance}) {
    state = state!.copyWith(
      attendance: !attendance,
      leavingEarly: false,
      lateness: false,
      absence: false,
    );
  }

  void setLeavingEarly({required bool leavingEarly}) {
    state = state!.copyWith(
      attendance: false,
      leavingEarly: !leavingEarly,
      lateness: false,
      absence: false,
    );
  }

  void setLateness({required bool lateness}) {
    state = state!.copyWith(
      attendance: false,
      leavingEarly: false,
      lateness: !lateness,
      absence: false,
    );
  }

  void setAbsence({required bool absence}) {
    state = state!.copyWith(
      attendance: false,
      leavingEarly: false,
      lateness: false,
      absence: !absence,
    );
  }
}

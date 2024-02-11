import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../database/auth/auth_controller.dart';
import '../../../../../database/group/group/group.dart';
import '../../../../../database/group/group/group_controller.dart';
import '../../../../../database/group/membership/group_membership_controller.dart';
import '../../../../../database/group/schedule/member_schedule/member_schedule_controller.dart';
import '../../../../../database/group/schedule/schedule/schedule.dart';
import '../../../../../database/group/schedule/schedule/schedule_controller.dart';

final checkGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final groupIsExistStream =
      GroupMembershipController.readAllWithUserId(userDocId);

  await for (final groupIsExist in groupIsExistStream) {
    yield groupIsExist.isNotEmpty;
  }
});

final setMemberScheduleProvider = StateNotifierProvider.family<
    _SetMemberScheduleNotifier, _SetMemberScheduleViewer?, String>(
  (ref, groupScheduleId) => _SetMemberScheduleNotifier(groupScheduleId),
);

class _SetMemberScheduleViewer {
  _SetMemberScheduleViewer({
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

  _SetMemberScheduleViewer copyWith({
    DateTime? startAt,
    DateTime? endAt,
    bool? attendance,
    bool? leavingEarly,
    bool? lateness,
    bool? absence,
  }) {
    return _SetMemberScheduleViewer(
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      attendance: attendance ?? this.attendance,
      leavingEarly: leavingEarly ?? this.leavingEarly,
      lateness: lateness ?? this.lateness,
      absence: absence ?? this.absence,
    );
  }
}

class _SetMemberScheduleNotifier
    extends StateNotifier<_SetMemberScheduleViewer?> {
  _SetMemberScheduleNotifier(String groupScheduleId)
      : super(_SetMemberScheduleViewer()) {
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

    final memberScheduleId = await GroupMemberScheduleSetting.readDocId(
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

    state = _SetMemberScheduleViewer(
      startAt: initStartAt,
      endAt: initEndAt,
      attendance: memberSchedule.attendance,
      leavingEarly: memberSchedule.leaveEarly,
      lateness: memberSchedule.lateness,
      absence: memberSchedule.absence,
    );
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

class GroupMemberScheduleSetting {
  GroupMemberScheduleSetting._internal();
  static final GroupMemberScheduleSetting _instance =
      GroupMemberScheduleSetting._internal();
  static GroupMemberScheduleSetting get instance => _instance;

  static Future<void> update({
    required String scheduleId,
    bool? attendance,
    bool? leaveEarly,
    bool? lateness,
    bool? absence,
    DateTime? startAt,
    DateTime? endAt,
  }) async {
    try {
      final userDocId = await AuthController.getCurrentUserId();
      if (userDocId == null) {
        throw Exception('User not logged in.');
      }
      final docId = await readDocId(scheduleId, userDocId);
      if (docId == null) {
        return;
      }
      await GroupMemberScheduleController.update(
        docId: docId,
        attendance: attendance,
        leaveEarly: leaveEarly,
        lateness: lateness,
        absence: absence,
        startAt: startAt,
        endAt: endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Failed to update database. $e');
    }
  }

  static Future<String?> readDocId(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      final docId =
          await GroupMemberScheduleController.readDocIdWithScheduleIdAndUserId(
        scheduleId: scheduleId,
        userDocId: userDocId,
      );
      return docId;
    } on FirebaseException catch (e) {
      throw Exception('Failed to read Doc ID. $e');
    }
  }

  static Future<String?> readGroupMembershipSchedule() async {
    return null;
  }
}

class GroupProfileWithScheduleWithId {
  GroupProfileWithScheduleWithId({
    required this.groupScheduleId,
    required this.groupSchedule,
    required this.groupId,
    required this.groupProfile,
  });
  final String groupScheduleId;
  final GroupSchedule groupSchedule;
  final String groupId;
  final GroupProfile groupProfile;
}

final readUserScheduleProvider =
    StreamProvider<List<GroupProfileWithScheduleWithId>>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  final groupMemberships =
      await GroupMembershipController.readAllWithUserId(userDocId).first;

  var combinedSchedules = <GroupProfileWithScheduleWithId>[];

  for (final membership in groupMemberships) {
    if (membership == null) {
      continue;
    }

    final groupProfile = await GroupController.read(membership.groupId).first;
    final scheduleIds =
        await GroupScheduleController.readAllScheduleId(membership.groupId)
            .first;

    if (groupProfile == null) {
      continue;
    }

    for (final scheduleId in scheduleIds) {
      if (scheduleId == null) {
        continue;
      }

      final schedule = await GroupScheduleController.read(scheduleId);

      if (schedule != null) {
        combinedSchedules.add(
          GroupProfileWithScheduleWithId(
            groupScheduleId: scheduleId,
            groupSchedule: schedule,
            groupId: membership.groupId,
            groupProfile: groupProfile,
          ),
        );
      }
    }
  }

  yield combinedSchedules;
});

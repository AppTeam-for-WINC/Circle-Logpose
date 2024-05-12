import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/models/database/group/member_schedule.dart';

import '../../../../models/database/group/group_schedule.dart';
import '../../../../server/auth/auth_controller.dart';
import '../../../../server/database/group_schedule_controller.dart';
import '../../../../server/database/member_schedule_controller.dart';

final groupMemberScheduleProvider = StateNotifierProvider.family<
    _MemberScheduleNotifier, GroupMemberSchedule?, String>(
  (ref, groupScheduleId) => _MemberScheduleNotifier(groupScheduleId),
);

class _MemberScheduleNotifier extends StateNotifier<GroupMemberSchedule?> {
  _MemberScheduleNotifier(String groupScheduleId) : super(null) {
    initSchedule(groupScheduleId);
  }

  Future<void> initSchedule(String groupScheduleId) async {
    try {
      final groupSchedule = await _fetchGroupSchedule(groupScheduleId);
      final userDocId = await _fetchUserDocId();
      final memberScheduleDocId =
          await _fetchScheduleId(groupScheduleId, userDocId);
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
    } on Exception catch (e) {
      state = null;
      debugPrint('Error initializing member schedule $e');
    }
  }

  Future<GroupSchedule> _fetchGroupSchedule(String groupScheduleId) async {
    final groupSchedule = await GroupScheduleController.read(groupScheduleId);
    if (groupSchedule == null) {
      state = null;
    }
    return groupSchedule!;
  }

  Future<String> _fetchUserDocId() async {
    final userDocId = await AuthController.fetchCurrentUserId();
    if (userDocId == null) {
      state = null;
      debugPrint('User not logged in.');
    }
    return userDocId!;
  }

  Future<String> _fetchScheduleId(
    String groupScheduleId,
    String userDocId,
  ) async {
    final memberScheduleDocId =
        await _fetchMemberScheduleDocId(groupScheduleId, userDocId);
    if (memberScheduleDocId == null) {
      state = null;
    }
    return memberScheduleDocId!;
  }

  static Future<String?> _fetchMemberScheduleDocId(
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

  Future<GroupMemberSchedule> _fetchMemberSchedule(
    String memberScheduleDocId,
  ) async {
    final memberSchedule =
        await GroupMemberScheduleController.read(memberScheduleDocId);
    if (memberSchedule == null) {
      state = null;
    }
    return memberSchedule!;
  }

  /// Set Group membership's schedule of startAt.
  Future<void> setStartAt(DateTime startAt) async {
    try {
      state = state!.copyWith(startAt: startAt);
    } on Exception catch (e) {
      state = null;
      debugPrint('Faield to update startAt. $e');
    }
  }

  /// Update Group membership's schedule of startAt.
  Future<void> updateStartAt(
    DateTime? startAt,
  ) async {
    await GroupMemberScheduleController.update(
      docId: state!.scheduleId,
      startAt: startAt,
    );
  }

  /// Set Group membership's schedule of endAt.
  Future<void> setEndAt(DateTime endAt) async {
    try {
      state = state!.copyWith(endAt: endAt);
    } on Exception catch (e) {
      state = null;
      debugPrint('Failed to update endAt. $e');
    }
  }

  /// Update Group membership's schedule of endAt.
  Future<void> updateEndAt(
    DateTime? endAt,
  ) async {
    await GroupMemberScheduleController.update(
      docId: state!.scheduleId,
      endAt: endAt,
    );
  }

  /// Update Group membership's schedule of attendance.
  Future<void> updateAttendance({required bool attendance}) async {
    try {
      final updatedState = state!.copyWith(
        attendance: !attendance,
        leaveEarly: false,
        lateness: false,
        absence: false,
      );
      await GroupMemberScheduleController.update(
        docId: state!.scheduleId,
        attendance: !attendance,
        leaveEarly: false,
        lateness: false,
        absence: false,
      );
      state = updatedState;
    } on Exception catch (e) {
      state = null;
      debugPrint('Failed to update attendance. $e');
    }
  }

  /// Update Group membership's schedule of leaveEarly.
  Future<void> updateLeaveEarly({required bool leaveEarly}) async {
    try {
      final updatedState = state!.copyWith(
        attendance: false,
        leaveEarly: !leaveEarly,
        lateness: false,
        absence: false,
      );
      await GroupMemberScheduleController.update(
        docId: state!.scheduleId,
        attendance: false,
        leaveEarly: !leaveEarly,
        lateness: false,
        absence: false,
      );
      state = updatedState;
    } on Exception catch (e) {
      state = null;
      debugPrint('Failed to update leaveEarly. $e');
    }
  }

  /// Update Group membership's schedule of lateness.
  Future<void> updateLateness({required bool lateness}) async {
    try {
      final updatedState = state!.copyWith(
        attendance: false,
        leaveEarly: false,
        lateness: !lateness,
        absence: false,
      );
      await GroupMemberScheduleController.update(
        docId: state!.scheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: !lateness,
        absence: false,
      );
      state = updatedState;
    } on Exception catch (e) {
      state = null;
      debugPrint('Failed to update lateness. $e');
    }
  }

  /// Update Group membership's schedule of absence.
  Future<void> updateAbsence({required bool absence}) async {
    try {
      final updatedState = state!.copyWith(
        attendance: false,
        leaveEarly: false,
        lateness: false,
        absence: !absence,
      );
      await GroupMemberScheduleController.update(
        docId: state!.scheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: false,
        absence: !absence,
      );
      state = updatedState;
    } on Exception catch (e) {
      state = null;
      debugPrint('Failed to update absence. $e');
    }
  }
}

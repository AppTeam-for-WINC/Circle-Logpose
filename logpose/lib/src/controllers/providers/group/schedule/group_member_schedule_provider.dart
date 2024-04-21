import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/models/group/database/member_schedule.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';

final groupMemberScheduleProvider = StateNotifierProvider.family<
    _UpdateMemberScheduleNotifier, GroupMemberSchedule?, String>(
  (ref, groupScheduleId) => _UpdateMemberScheduleNotifier(groupScheduleId),
);

class _UpdateMemberScheduleNotifier
    extends StateNotifier<GroupMemberSchedule?> {
  _UpdateMemberScheduleNotifier(String groupScheduleId) : super(null) {
    _initSchedule(groupScheduleId);
  }

  Future<void> _initSchedule(String groupScheduleId) async {
    try {
      final groupSchedule = await GroupScheduleController.read(groupScheduleId);
      if (groupSchedule == null) {
        state = null;
        return;
      }

      final userDocId = await AuthController.getCurrentUserId();
      if (userDocId == null) {
        state = null;
        debugPrint('User not logged in.');
        return;
      }

      final memberScheduleId = await _readDocId(groupScheduleId, userDocId);
      if (memberScheduleId == null) {
        state = null;
        return;
      }

      final memberSchedule =
          await GroupMemberScheduleController.read(memberScheduleId);
      if (memberSchedule == null) {
        state = null;
        return;
      }

      state = GroupMemberSchedule(
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
    } on FirebaseException catch (e) {
      state = null;
      debugPrint('Error initializing member schedule $e');
    }
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

  Future<void> updateStartAt(DateTime startAt) async {
    try {
      final updatedState = state!.copyWith(startAt: startAt);
      await GroupMemberScheduleController.update(
        docId: state!.scheduleId,
        startAt: startAt,
      );
      state = updatedState;
    } on Exception catch (e) {
      state = null;
      debugPrint('Faield to update startAt. $e');
    }
  }

  Future<void> updateEndAt(DateTime endAt) async {
    try {
      final updatedState = state!.copyWith(endAt: endAt);
      await GroupMemberScheduleController.update(
        docId: state!.scheduleId,
        endAt: endAt,
      );
      state = updatedState;
    } on Exception catch (e) {
      state = null;
      debugPrint('Failed to update endAt. $e');
    }
  }

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

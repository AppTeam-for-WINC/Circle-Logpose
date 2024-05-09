import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';

import '../../../../utils/color/color_exchanger.dart';
import '../../../../utils/time/time_utils.dart';

import '../../../validation/schedule_validation.dart';

import 'create_members_schedule.dart';

/// Create schedule.
class CreateGroupSchedule {
  CreateGroupSchedule._internal();
  static final CreateGroupSchedule _instance = CreateGroupSchedule._internal();
  static CreateGroupSchedule get instance => _instance;

  static Future<String?> create(
    String groupId,
    String title,
    Color color,
    String place,
    String detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
      final validateError = _validate(
        title: title,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
      );
      if (validateError != null) {
        return validateError;
      }

      final scheduleId = await _createSchedule(
        groupId,
        title,
        color,
        place,
        detail,
        startAt,
        endAt,
      );
      await _createMemberSchedule(groupId, scheduleId);

      return null;
    } on FirebaseException catch (e) {
      return 'Error: $e';
    }
  }

  static String? _validate({
    required String title,
    required String place,
    required String detail,
    required DateTime startAt,
    required DateTime endAt,
  }) {
    final titleError = ScheduleValidation.titleValidation(title);
    final placeError = ScheduleValidation.placeValidation(place);
    final detailError = ScheduleValidation.detailValidation(detail);
    if (titleError != null) {
      return titleError;
    }

    if (placeError != null) {
      return placeError;
    }

    if (detailError != null) {
      return detailError;
    }

    if (!checkStartAtAfterEndAt(startAt, endAt)) {
      const errorMessage = 'Start time must be set before end time';
      return errorMessage;
    }

    return null;
  }

  static String _colorToHex(Color color) {
    return colorToHex(color);
  }

  static Future<String> _createSchedule(
    String groupId,
    String title,
    Color color,
    String place,
    String detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    // Create Group Schedule, return Group Schedule doc ID.
    try {
      return GroupScheduleController.create(
        groupId: groupId,
        title: title,
        color: _colorToHex(color),
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to created schedule. $e');
    }
  }

  static Future<List<String>> _readAllUserDocIdWithGroupId(
    String groupId,
  ) async {
    return GroupMembershipController.readAllUserDocIdWithGroupId(groupId);
  }

  static Future<void> _createMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    for (final userDocId in await _readAllUserDocIdWithGroupId(groupId)) {
      await CreateMembersSchedule.create(
        scheduleId: scheduleId,
        userId: userDocId,
      );
    }
  }
}

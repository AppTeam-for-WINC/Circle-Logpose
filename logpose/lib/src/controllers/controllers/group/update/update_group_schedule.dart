import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../server/database/group_schedule_controller.dart';
import '../../../../utils/color/color_exchanger.dart';
import '../../../validation/schedule_validation.dart';

/// Update schedule.
class UpdateGroupSchedule {
  UpdateGroupSchedule._internal();
  static final UpdateGroupSchedule _instance = UpdateGroupSchedule._internal();
  static UpdateGroupSchedule get instance => _instance;

  static Future<String?> updateSchedule(
    String docId,
    String groupId,
    String title,
    Color color,
    String place,
    String detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
      final scheduleValidation = _scheduleValidation(title, place, detail);
      if (scheduleValidation != null) {
        return scheduleValidation;
      }

      await _updateGroupSchedule(
        docId,
        groupId,
        title,
        color,
        place,
        detail,
        startAt,
        endAt,
      );

      return null;
    } on FirebaseException catch (e) {
      throw Exception('Error: $e');
    }
  }

  static String? _scheduleValidation(
    String title,
    String place,
    String detail,
  ) {
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

    return null;
  }

  static Future<void> _updateGroupSchedule(
    String docId,
    String groupId,
    String title,
    Color color,
    String? place,
    String? detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    final colorToString = colorToHex(color);
    await GroupScheduleController.update(
      docId: docId,
      groupId: groupId,
      title: title,
      color: colorToString,
      place: place,
      detail: detail,
      startAt: startAt,
      endAt: endAt,
    );
  }
}

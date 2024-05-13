import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/custom/schedule_params_model.dart';

import '../../../../server/database/group_schedule_controller.dart';

import '../../../../utils/color/color_exchanger.dart';

import '../../../validation/schedule_validation.dart';

/// Used with group_schedule_updater_provider.
class GroupScheduleUpdater {
  const GroupScheduleUpdater();

  Future<String?> update(String docId, ScheduleParams scheduleParams) async {
    try {
      return await _attemptToUpdate(docId, scheduleParams);
    } on Exception catch (e) {
      throw Exception('Error: failed to update group schedule. $e');
    }
  }

  Future<String?> _attemptToUpdate(
    String docId,
    ScheduleParams scheduleParams,
  ) async {
    final validationError = _scheduleValidation(
      scheduleParams.title,
      scheduleParams.place,
      scheduleParams.detail,
    );
    if (validationError != null) {
      return validationError;
    }

    await _updateGroupSchedule(docId, scheduleParams);

    return null;
  }

  String? _scheduleValidation(
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

  Future<void> _updateGroupSchedule(
    String docId,
    ScheduleParams scheduleParams,
  ) async {
    final colorToString = _colorToHex(scheduleParams.color);
    await _updateSchedule(docId, colorToString, scheduleParams);
  }

  String _colorToHex(Color color) {
    return colorToHex(color);
  }

  Future<void> _updateSchedule(
    String docId,
    String color,
    ScheduleParams scheduleParams,
  ) async {
    try {
      await GroupScheduleController.update(
        docId: docId,
        groupId: scheduleParams.groupId,
        title: scheduleParams.title,
        color: color,
        place: scheduleParams.place,
        detail: scheduleParams.detail,
        startAt: scheduleParams.startAt,
        endAt: scheduleParams.endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update group schedule. ${e.message}');
    }
  }
}

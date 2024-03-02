import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../services/database/group_schedule_controller.dart';
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
      final titleValidationErrorMessage =
          ScheduleValidation.titleValidation(title);
      final placeValidationErrorMessage =
          ScheduleValidation.placeValidation(place);
      final detailValidationErrorMessage =
          ScheduleValidation.detailValidation(detail);
      if (titleValidationErrorMessage != null) {
        return titleValidationErrorMessage;
      }

      if (placeValidationErrorMessage != null) {
        return placeValidationErrorMessage;
      }

      if (detailValidationErrorMessage != null) {
        return detailValidationErrorMessage;
      }
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

      return null;
    } on FirebaseException catch (e) {
      throw Exception('Error: $e');
    }
  }
}

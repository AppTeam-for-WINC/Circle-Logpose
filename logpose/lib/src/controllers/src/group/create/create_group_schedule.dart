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
      final validateErrorMessage = _validate(
        title: title,
        place: place,
        detail: detail,
      );
      if (validateErrorMessage != null) {
        return validateErrorMessage;
      }

      final colorToString = colorToHex(color);

      if (!checkStartAtAfterEndAt(startAt, endAt)) {
        const errorMessage = 'Start time must be set before end time';
        return errorMessage;
      }

      final scheduleId = await GroupScheduleController.create(
        groupId: groupId,
        title: title,
        color: colorToString,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
      );

      final userDocIds =
          await GroupMembershipController.readAllUserDocIdWithGroupId(groupId);
          
      for (final userDocId in userDocIds) {
        await CreateMembersSchedule.create(
          scheduleId: scheduleId,
          userId: userDocId,
        );
      }

      return null;
    } on FirebaseException catch (e) {
      throw Exception('Error: $e');
    }
  }

  static String? _validate({
    required String title,
    required String place,
    required String detail,
  }) {
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

    return null;
  }
}

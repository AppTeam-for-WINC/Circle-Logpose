import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/custom/schedule_params_model.dart';

import '../../../../server/database/group_membership_controller.dart';
import '../../../../server/database/group_schedule_controller.dart';
import '../../../../server/database/member_schedule_controller.dart';

import '../../../../utils/color/color_exchanger.dart';
import '../../../../utils/time/time_utils.dart';

import '../../../validation/schedule_validation.dart';

/// Used with group_schedule_creator_provider.
class GroupScheduleCreator {
  const GroupScheduleCreator();

  Future<String?> create(ScheduleParams scheduleViewParams) async {
    try {
      return await _attemptToCreateSchedule(scheduleViewParams);
    } on Exception catch (e) {
      return 'Error: failed to create group schedule. $e';
    }
  }

  Future<String?> _attemptToCreateSchedule(
    ScheduleParams scheduleViewParams,
  ) async {
    final validateError = _validateScheduleDetails(
      title: scheduleViewParams.title,
      place: scheduleViewParams.place,
      detail: scheduleViewParams.detail,
      startAt: scheduleViewParams.startAt,
      endAt: scheduleViewParams.endAt,
    );
    if (validateError != null) {
      return validateError;
    }

    final scheduleId = await _createAndRetrieveScheduleId(scheduleViewParams);
    await _createAllMemberSchedule(scheduleViewParams.groupId, scheduleId);

    return null;
  }

  String? _validateScheduleDetails({
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

  Future<String> _createAndRetrieveScheduleId(
    ScheduleParams scheduleViewParams,
  ) async {
    try {
      return GroupScheduleController.create(
        groupId: scheduleViewParams.groupId,
        title: scheduleViewParams.title,
        color: _colorToHex(scheduleViewParams.color),
        place: scheduleViewParams.place,
        detail: scheduleViewParams.detail,
        startAt: scheduleViewParams.startAt,
        endAt: scheduleViewParams.endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create schedule. ${e.message}');
    }
  }

  String _colorToHex(Color color) {
    return colorToHex(color);
  }

  Future<void> _createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    try {
      await _attemptToCreateAllMemberSchedule(groupId, scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedules. ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error: unexpected error occured. $e');
    }
  }

  Future<void> _attemptToCreateAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    final snapshot = await _fetchAllUserDocIdWithGroupId(groupId);
    await Future.wait(
      snapshot.map((userDocId) async {
        await _createMemberSchedule(scheduleId, userDocId);
      }),
    );
  }

  Future<void> _createMemberSchedule(String scheduleId, String userId) async {
    try {
      await GroupMemberScheduleController.create(
        scheduleId: scheduleId,
        userId: userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedule. ${e.message}');
    }
  }

  Future<List<String>> _fetchAllUserDocIdWithGroupId(String groupId) async {
    try {
      return GroupMembershipController.readAllUserDocIdWithGroupId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch all user doc Id. ${e.message}');
    }
  }
}

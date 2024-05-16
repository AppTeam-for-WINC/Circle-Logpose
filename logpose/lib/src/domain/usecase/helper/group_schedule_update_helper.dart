import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/schedule_params_model.dart';
import '../../../models/custom/schedule_validation_params.dart';

import '../../../utils/color/color_exchanger.dart';

import '../../providers/group/schedule/group_schedule_controller_provider.dart';
import '../../providers/validator/validator_controller_provider.dart';

class GroupScheduleUpdateHelper {
  const GroupScheduleUpdateHelper({required this.ref});
  final Ref ref;

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
    final validationError = _validateSchedule(
      ScheduleValidationParams(
        title: scheduleParams.title,
        place: scheduleParams.place,
        detail: scheduleParams.detail,
        startAt: scheduleParams.startAt,
        endAt: scheduleParams.endAt,
      ),
    );
    if (validationError != null) {
      return validationError;
    }

    await _updateGroupSchedule(docId, scheduleParams);

    return null;
  }

  String? _validateSchedule(ScheduleValidationParams schedule) {
    final validator = ref.read(validatorControllerProvider);
    return validator.validateSchedule(schedule);
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
      final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);
      await groupScheduleRepository.update(
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

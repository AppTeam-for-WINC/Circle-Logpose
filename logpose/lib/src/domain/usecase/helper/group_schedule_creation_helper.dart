import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/schedule_params_model.dart';
import '../../../models/custom/schedule_validation_params.dart';

import '../../../utils/color/color_exchanger.dart';

import '../../providers/group/schedule/group_schedule_controller_provider.dart';
import '../../providers/validator/validator_controller_provider.dart';

import '../group_member_schedule_use_case.dart';

class GroupScheduleCreationHelper {
  const GroupScheduleCreationHelper({required this.ref});
  final Ref ref;

  Future<String?> createSchedule(ScheduleParams scheduleViewParams) async {
    try {
      return await _attemptToCreateSchedule(scheduleViewParams);
    } on Exception catch (e) {
      return 'Error: failed to create group schedule. $e';
    }
  }

  Future<String?> _attemptToCreateSchedule(
    ScheduleParams scheduleViewParams,
  ) async {
    final validationError = _validateSchedule(
      ScheduleValidationParams(
        title: scheduleViewParams.title,
        place: scheduleViewParams.place,
        detail: scheduleViewParams.detail,
        startAt: scheduleViewParams.startAt,
        endAt: scheduleViewParams.endAt,
      ),
    );
    if (validationError != null) {
      return validationError;
    }

    final scheduleId = await _createAndRetrieveScheduleId(scheduleViewParams);
    await _createAllMemberSchedule(scheduleViewParams.groupId, scheduleId);

    return null;
  }

  String? _validateSchedule(ScheduleValidationParams schedule) {
    final validator = ref.read(validatorControllerProvider);
    return validator.validateSchedule(schedule);
  }

  Future<String> _createAndRetrieveScheduleId(
    ScheduleParams scheduleViewParams,
  ) async {
    try {
      return await _attemptToCreateAndRetrieveScheduleId(scheduleViewParams);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create schedule. ${e.message}');
    }
  }

  Future<String> _attemptToCreateAndRetrieveScheduleId(
    ScheduleParams scheduleViewParams,
  ) async {
    final color = _colorToHex(scheduleViewParams.color);
    final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);

    return groupScheduleRepository.createAndRetrieveScheduleId(
      groupId: scheduleViewParams.groupId,
      title: scheduleViewParams.title,
      color: color,
      place: scheduleViewParams.place,
      detail: scheduleViewParams.detail,
      startAt: scheduleViewParams.startAt,
      endAt: scheduleViewParams.endAt,
    );
  }

  String _colorToHex(Color color) {
    return colorToHex(color);
  }

  Future<void> _createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);
    await memberScheduleUseCase.createAllMemberSchedule(groupId, scheduleId);
  }
}

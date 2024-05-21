import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/interface/i_group_schedule_repository.dart';

import '../../../data/repository/database/group_schedule_repository.dart';

import '../../../utils/color/color_exchanger.dart';

import '../../interface/group_member_schedule/i_group_member_schedule_creation_use_case.dart';
import '../../interface/group_schedule/i_group_schedule_creation_use_case.dart';
import '../../model/schedule_params_model.dart';
import '../../model/schedule_validation_params.dart';

import '../usecase_member_schedule/group_member_schedule_creation_use_case.dart';

final groupScheduleCreationUseCaseProvider =
    Provider<IGroupScheduleCreationUseCase>((ref) {
  final memberScheduleCreationUseCase =
      ref.read(groupMemberScheduleCreationUseCaseProvider);
  final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);
  final validator = ref.read(validatorControllerProvider);

  return GroupScheduleCreationUseCase(
    memberScheduleCreationUseCase: memberScheduleCreationUseCase,
    groupScheduleRepository: groupScheduleRepository,
    validator: validator,
  );
});

class GroupScheduleCreationUseCase implements IGroupScheduleCreationUseCase {
  const GroupScheduleCreationUseCase({
    required this.memberScheduleCreationUseCase,
    required this.groupScheduleRepository,
    required this.validator,
  });

  final IGroupMemberScheduleCreationUseCase memberScheduleCreationUseCase;
  final IGroupScheduleRepository groupScheduleRepository;
  final ValidatorController validator;

  @override
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
    return validator.validateSchedule(schedule);
  }

  Future<String> _createAndRetrieveScheduleId(
    ScheduleParams scheduleViewParams,
  ) async {
    try {
      return await _attemptToCreateAndRetrieveScheduleId(scheduleViewParams);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create schedule. ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error: failed to create schedule. $e');
    }
  }

  Future<String> _attemptToCreateAndRetrieveScheduleId(
    ScheduleParams scheduleViewParams,
  ) async {
    final color = _colorToHex(scheduleViewParams.color);

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
    await memberScheduleCreationUseCase.createAllMemberSchedule(
      groupId,
      scheduleId,
    );
  }
}

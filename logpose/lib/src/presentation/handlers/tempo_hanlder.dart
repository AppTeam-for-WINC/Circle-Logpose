// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/schedule_params_model.dart';

import '../../domain/providers/error_message/schedule_error_msg_provider.dart';

import '../controllers/group_schedule_controller.dart';
import '../navigations/pop_navigator.dart';
import '../notifiers/group_schedule_notifier.dart';

class ScheduleSettingSaveButtonHandler {
  ScheduleSettingSaveButtonHandler({
    required this.context,
    required this.ref,
    required this.groupId,
    required this.defaultGroupId,
    required this.groupScheduleId,
    required this.createOrUpdate,
    required this.scheduleData,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String? groupId;
  final String? defaultGroupId;
  final String? groupScheduleId;
  final String createOrUpdate;
  final ScheduleParams scheduleData;

  Future<void> handleToCreateSchedule() async {
    _checkSelectedGroup();
    final errorMessage = await _createOrUpdateSchedule();
    if (errorMessage != null) {
      _setErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  void _checkSelectedGroup() {
    if (groupId == null && defaultGroupId == null) {
      _setErrorMessage('No selected group.');
    } else {
      _setGroupId();
    }
  }

  void _setErrorMessage(String errorMessage) {
    ref.watch(scheduleErrorMessageProvider.notifier).state = errorMessage;
  }

  void _setGroupId() {
    ref
        .watch(groupScheduleNotifierProvider(groupScheduleId).notifier)
        .setGroupId(defaultGroupId!);
  }

  Future<String?> _createOrUpdateSchedule() async {
    if (createOrUpdate == 'create') {
      return _createSchedule();
    } else if (createOrUpdate == 'update') {
      return _updateSchedule();
    } else {
      throw Exception('Error: set another mode.');
    }
  }

  Future<String?> _createSchedule() async {
    final scheduleController = ref.read(groupScheduleControllerProvider);
    return scheduleController.createSchedule(scheduleData);
  }

  Future<String?> _updateSchedule() async {
    final scheduleController = ref.read(groupScheduleControllerProvider);
    return scheduleController.updateSchedule(groupScheduleId!, scheduleData);
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      PopNavigator(context).pop();
    }
  }
}

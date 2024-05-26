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
    required this.title,
    required this.color,
    required this.place,
    required this.detail,
    required this.startAt,
    required this.endAt,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String? groupId;
  final String? defaultGroupId;
  final String? groupScheduleId;
  final String title;
  final Color color;
  final String place;
  final String detail;
  final DateTime startAt;
  final DateTime endAt;

  Future<void> handleToCreateSchedule() async {
    _checkSelectedGroup();
    final errorMessage = await _createSchedule();
    if (errorMessage != null) {
      _setErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  Future<void> handleToUpdateSchedule() async {
    _checkSelectedGroup();
    final errorMessage = await _updateSchedule();
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

  Future<String?> _createSchedule() async {
    final scheduleData = _mapToScheduleParams();
    final scheduleController = ref.read(groupScheduleControllerProvider);
    return scheduleController.createSchedule(scheduleData);
  }

  Future<String?> _updateSchedule() async {
    final scheduleData = _mapToScheduleParams();
    final scheduleController = ref.read(groupScheduleControllerProvider);
    return scheduleController.updateSchedule(groupScheduleId!, scheduleData);
  }

  ScheduleParams _mapToScheduleParams() {
    return ScheduleParams(
      groupId:
          ref.read(groupScheduleNotifierProvider(null))!.groupId ?? groupId,
      title: title,
      color: color,
      place: place,
      detail: detail,
      startAt: startAt,
      endAt: endAt,
    );
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      PopNavigator(context).pop();
    }
  }
}

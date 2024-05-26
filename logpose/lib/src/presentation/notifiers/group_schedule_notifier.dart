import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_schedule_facade.dart';

import '../../domain/entity/group_schedule.dart';

import '../../domain/providers/text_field/schedule_detail_controller_provider.dart';
import '../../domain/providers/text_field/schedule_place_controller_provider.dart';
import '../../domain/providers/text_field/schedule_title_controller_provider.dart';

import '../../utils/color/color_exchanger.dart';

import '../states/group_schedule_state.dart';

final groupScheduleNotifierProvider = StateNotifierProvider.family
    .autoDispose<_SetGroupScheduleNotifier, GroupScheduleState?, String?>(
  _SetGroupScheduleNotifier.new,
);

class _SetGroupScheduleNotifier extends StateNotifier<GroupScheduleState?> {
  _SetGroupScheduleNotifier(this.ref, String? scheduleId)
      : groupScheduleFacade = ref.read(groupScheduleFacadeProvider),
        super(GroupScheduleState()) {
    if (scheduleId != null) {
      _loadExistingSchedule(scheduleId);
    }
  }

  final Ref ref;
  final GroupScheduleFacade groupScheduleFacade;

  Future<void> _loadExistingSchedule(String scheduleId) async {
    try {
      final schedule = await groupScheduleFacade.fetchGroupSchedule(scheduleId);
      _setScheduleControllers(schedule);
      final scheduleState = _mapToState(schedule);
      if (mounted) {
        state = scheduleState;
      }
    } on Exception catch (e) {
      throw Exception('Failed to load schedule. $e');
    }
  }

  void _setScheduleControllers(GroupSchedule schedule) {
    ref.read(scheduleTitleControllerProvider.notifier).state.text =
        schedule.title;
    ref.read(schedulePlaceControllerProvider.notifier).state.text =
        schedule.place ?? '';
    ref.read(scheduleDetailControllerProvider.notifier).state.text =
        schedule.detail ?? '';
  }

  Color _hexToColor(String hexColorString) {
    return hexToColor(hexColorString);
  }

  GroupScheduleState _mapToState(GroupSchedule schedule) {
    return GroupScheduleState(
      groupId: schedule.groupId,
      color: _hexToColor(schedule.color),
      startAt: schedule.startAt,
      endAt: schedule.endAt,
    );
  }

  void setGroupId(String groupId) {
    state = state!.copyWith(groupId: groupId);
  }

  void setColor(Color color) {
    state = state!.copyWith(color: color);
  }

  void setStartAt(DateTime startAt) {
    state = state!.copyWith(startAt: startAt);
  }

  void setEndAt(DateTime endAt) {
    state = state!.copyWith(endAt: endAt);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/color/color_exchanger.dart';

import '../../../entity/group_schedule.dart';

import '../../../usecase/facade/group_schedule_facade.dart';

import '../../text_field/schedule_detail_controller_provider.dart';
import '../../text_field/schedule_place_controller_provider.dart';
import '../../text_field/schedule_title_controller_provider.dart';

/// Set group schedule.
final setGroupScheduleProvider = StateNotifierProvider.family
    .autoDispose<_SetGroupScheduleNotifier, _GroupScheduleViewer?, String?>(
  // tear off -> (ref, scheduleId) => _SetGroupScheduleNotifier(ref, scheduleId)
  _SetGroupScheduleNotifier.new,
);

/// Schedule Object.
class _GroupScheduleViewer {
  _GroupScheduleViewer({
    this.groupId,
    this.color,
    DateTime? startAt,
    DateTime? endAt,
  })  : startAt = startAt ?? DateTime.now(),
        endAt = endAt ?? DateTime.now().add(const Duration(hours: 1));

  final String? groupId;
  final Color? color;
  final DateTime startAt;
  final DateTime endAt;

  // Update schedule data.
  _GroupScheduleViewer copyWith({
    String? groupId,
    Color? color,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return _GroupScheduleViewer(
      groupId: groupId ?? this.groupId,
      color: color ?? this.color,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }
}

/// Set a schedule to group.
class _SetGroupScheduleNotifier extends StateNotifier<_GroupScheduleViewer?> {
  _SetGroupScheduleNotifier(
    StateNotifierProviderRef<_SetGroupScheduleNotifier, _GroupScheduleViewer?>
        ref,
    String? scheduleId,
  ) : super(_GroupScheduleViewer()) {
    if (scheduleId != null) {
      _loadExistingSchedule(ref, scheduleId);
    } else {
      initSchedule();
    }
  }

  /// Initialize group schedule.
  void initSchedule() {
    state = _GroupScheduleViewer(
      color: const Color.fromARGB(255, 217, 0, 255),
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  /// Load existing a schedule.
  Future<void> _loadExistingSchedule(
    StateNotifierProviderRef<_SetGroupScheduleNotifier, _GroupScheduleViewer?>
        ref,
    String scheduleId,
  ) async {
    try {
      final schedule = await _fetchSchedule(ref, scheduleId);
      _setTitleController(ref, schedule.title);
      _setPlaceController(ref, schedule.place);
      _setDetailController(ref, schedule.detail);
      state = _GroupScheduleViewer(
        groupId: schedule.groupId,
        color: hexToColor(schedule.color),
        startAt: schedule.startAt,
        endAt: schedule.endAt,
      );
    } on Exception catch (e) {
      throw Exception('Failed to load schedule. $e');
    }
  }

  Future<GroupSchedule> _fetchSchedule(
    StateNotifierProviderRef<_SetGroupScheduleNotifier, _GroupScheduleViewer?>
        ref,
    String scheduleId,
  ) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.fetchGroupSchedule(scheduleId);
  }

  void _setTitleController(
    StateNotifierProviderRef<_SetGroupScheduleNotifier, _GroupScheduleViewer?>
        ref,
    String title,
  ) {
    ref.read(scheduleTitleControllerProvider.notifier).state.text = title;
  }

  void _setPlaceController(
    StateNotifierProviderRef<_SetGroupScheduleNotifier, _GroupScheduleViewer?>
        ref,
    String? place,
  ) {
    ref.read(schedulePlaceControllerProvider.notifier).state.text = place ?? '';
  }

  void _setDetailController(
    StateNotifierProviderRef<_SetGroupScheduleNotifier, _GroupScheduleViewer?>
        ref,
    String? detail,
  ) {
    ref.read(scheduleDetailControllerProvider.notifier).state.text =
        detail ?? '';
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

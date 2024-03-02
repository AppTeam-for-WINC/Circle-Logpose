import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/database/group_schedule_controller.dart';
import '../../../../utils/color/color_exchanger.dart';

final setGroupScheduleProvider = StateNotifierProvider.family<
    _SetUpdateGroupScheduleNotifier, _SetGroupScheduleViewer?, String>(
  (ref, scheduleId) => _SetUpdateGroupScheduleNotifier(scheduleId),
);

/// Schedule Object.
class _SetGroupScheduleViewer {
  _SetGroupScheduleViewer({
    this.groupId,
    this.color,
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? place,
    String? detail,
  })  : titleController = TextEditingController(text: title),
        placeController = TextEditingController(text: place),
        detailController = TextEditingController(text: detail),
        startAt = startAt ?? DateTime.now(),
        endAt = endAt ?? DateTime.now().add(const Duration(hours: 1));

  final String? groupId;
  final Color? color;
  final TextEditingController titleController;
  final DateTime startAt;
  final DateTime endAt;
  final TextEditingController placeController;
  final TextEditingController detailController;

  // Set updated schedule data.
  _SetGroupScheduleViewer copyWith({
    String? groupId,
    Color? color,
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? place,
    String? detail,
  }) {
    return _SetGroupScheduleViewer(
      groupId: groupId ?? this.groupId,
      color: color ?? this.color,
      title: title ?? titleController.text,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      place: place ?? placeController.text,
      detail: detail ?? detailController.text,
    );
  }
}

/// Set schedule to group.
class _SetUpdateGroupScheduleNotifier
    extends StateNotifier<_SetGroupScheduleViewer?> {
  _SetUpdateGroupScheduleNotifier(String scheduleId)
      : super(
          _SetGroupScheduleViewer(
            color: Colors.purple,
            title: '',
            startAt: DateTime.now(),
            endAt: DateTime.now().add(const Duration(hours: 1)),
            place: '',
            detail: '',
          ),
        ) {
    _initSchedule(scheduleId);
  }

  Future<void> _initSchedule(String scheduleId) async {
    final schedule = await GroupScheduleController.read(scheduleId);
    if (schedule == null) {
      return;
    }
    state = _SetGroupScheduleViewer(
      groupId: schedule.groupId,
      color: hexToColor(schedule.color),
      title: schedule.title,
      place: schedule.place,
      detail: schedule.detail,
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

  void setTitle(TextEditingController title) {
    state = state!.copyWith(title: title.text);
  }

  void setStartAt(DateTime startAt) {
    state = state!.copyWith(startAt: startAt);
  }

  void setEndAt(DateTime endAt) {
    state = state!.copyWith(endAt: endAt);
  }

  void setPlace(TextEditingController place) {
    state = state!.copyWith(place: place.text);
  }

  void setDetail(TextEditingController detail) {
    state = state!.copyWith(detail: detail.text);
  }
}

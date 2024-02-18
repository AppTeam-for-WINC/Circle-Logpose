import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/color/color_exchanger.dart';
import '../../../../services/database/crud/group_schedule_controller.dart';
import '../schedule_create/schedule_create_controller.dart';

final changeGroupScheduleProvider = StateNotifierProvider.family<
    _SetChangeGroupScheduleNotifier, _ChangeGroupScheduleViewer?, String>(
  (ref, scheduleId) => _SetChangeGroupScheduleNotifier(scheduleId),
);

/// Schedule Object.
class _ChangeGroupScheduleViewer {
  _ChangeGroupScheduleViewer({
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

  // Update schedule data.
  _ChangeGroupScheduleViewer copyWith({
    String? groupId,
    Color? color,
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? place,
    String? detail,
  }) {
    return _ChangeGroupScheduleViewer(
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
class _SetChangeGroupScheduleNotifier
    extends StateNotifier<_ChangeGroupScheduleViewer?> {
  _SetChangeGroupScheduleNotifier(String scheduleId)
      : super(
          _ChangeGroupScheduleViewer(
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
    state = _ChangeGroupScheduleViewer(
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

/// Update schedule.
class UpdateGroupSchedule {
  UpdateGroupSchedule._internal();
  static final UpdateGroupSchedule _instance = UpdateGroupSchedule._internal();
  static UpdateGroupSchedule get instance => _instance;

  static Future<String?> updateSchedule(
    String docId,
    String groupId,
    String title,
    Color color,
    String place,
    String detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
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
      final colorToString = colorToHex(color);

      await GroupScheduleController.update(
        docId: docId,
        groupId: groupId,
        title: title,
        color: colorToString,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
      );

      return null;
    } on FirebaseException catch (e) {
      throw Exception('Error: $e');
    }
  }
}

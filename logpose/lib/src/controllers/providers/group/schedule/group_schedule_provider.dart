import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupScheduleProvider =
    StateNotifierProvider<_SetGroupScheduleNotifier, _GroupScheduleViewer?>(
  (ref) => _SetGroupScheduleNotifier(),
);

/// Schedule Object.
class _GroupScheduleViewer {
  _GroupScheduleViewer({
    this.groupId,
    this.color = const Color.fromARGB(255, 217, 0, 255),
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
  final Color color;
  final TextEditingController titleController;
  final DateTime startAt;
  final DateTime endAt;
  final TextEditingController placeController;
  final TextEditingController detailController;

  // Update schedule data.
  _GroupScheduleViewer copyWith({
    String? groupId,
    Color? color,
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? place,
    String? detail,
  }) {
    return _GroupScheduleViewer(
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
class _SetGroupScheduleNotifier extends StateNotifier<_GroupScheduleViewer> {
  _SetGroupScheduleNotifier() : super(_GroupScheduleViewer());

  void initSchedule() {
    state = _GroupScheduleViewer(
      title: '',
      place: '',
      detail: '',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  void setGroupId(String groupId) {
    state = state.copyWith(groupId: groupId);
  }

  void setColor(Color color) {
    state = state.copyWith(color: color);
  }

  void setTitle(TextEditingController title) {
    state = state.copyWith(title: title.text);
  }

  void setStartAt(DateTime startAt) {
    state = state.copyWith(startAt: startAt);
  }

  void setEndAt(DateTime endAt) {
    state = state.copyWith(endAt: endAt);
  }

  void setPlace(TextEditingController place) {
    state = state.copyWith(place: place.text);
  }

  void setDetail(TextEditingController detail) {
    state = state.copyWith(detail: detail.text);
  }
}

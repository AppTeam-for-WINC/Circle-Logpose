import 'dart:ui';

class GroupScheduleState {
  GroupScheduleState({
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

  GroupScheduleState copyWith({
    String? groupId,
    Color? color,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return GroupScheduleState(
      groupId: groupId ?? this.groupId,
      color: color ?? this.color,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }
}

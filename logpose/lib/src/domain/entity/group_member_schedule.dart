import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMemberSchedule {
  const GroupMemberSchedule({
    required this.scheduleId,
    required this.userId,
    required this.attendance,
    required this.leaveEarly,
    required this.lateness,
    required this.absence,
    this.startAt,
    this.endAt,
    this.updatedAt,
    required this.createdAt,
  });

  GroupMemberSchedule copyWith({
    String? scheduleId,
    String? userId,
    bool? attendance,
    bool? leaveEarly,
    bool? lateness,
    bool? absence,
    DateTime? startAt,
    DateTime? endAt,
    Timestamp? updatedAt,
  }) {
    return GroupMemberSchedule(
      scheduleId: scheduleId ?? this.scheduleId,
      userId: userId ?? this.userId,
      attendance: attendance ?? this.attendance,
      leaveEarly: leaveEarly ?? this.leaveEarly,
      lateness: lateness ?? this.lateness,
      absence: absence ?? this.absence,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt,
    );
  }

  final String scheduleId;

  final String userId;

  final bool attendance;

  final bool leaveEarly;

  final bool lateness;

  final bool absence;

  final DateTime? startAt;

  final DateTime? endAt;

  final Timestamp? updatedAt;

  final Timestamp createdAt;
}

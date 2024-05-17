import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/time/time_utils.dart';

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

  factory GroupMemberSchedule.fromMap(
    Map<String, dynamic> data,
  ) {
    return GroupMemberSchedule(
      scheduleId: data['schedule_id'] as String,
      userId: data['user_id'] as String,
      attendance: data['attendance'] as bool,
      leaveEarly: data['leave_early'] as bool,
      lateness: data['lateness'] as bool,
      absence: data['absence'] as bool,
      startAt: convertTimestampToDateTime(data['start_at']),
      endAt: convertTimestampToDateTime(data['end_at']),
      updatedAt: data['updated_at'] as Timestamp?,
      createdAt: data['created_at'] as Timestamp,
    );
  }

  /// Schedule ID
  final String scheduleId;

  /// User ID
  final String userId;

  /// Attendance
  final bool attendance;

  /// Leave early
  final bool leaveEarly;

  /// Lateness
  final bool lateness;

  /// Absence
  final bool absence;

  /// Start time
  final DateTime? startAt;

  /// End time
  final DateTime? endAt;

  /// Updateed time
  final Timestamp? updatedAt;

  /// Created time
  final Timestamp createdAt;

  /// Set GroupMemberSchedule.
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
}

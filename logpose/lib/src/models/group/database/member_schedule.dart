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

  factory GroupMemberSchedule.fromMap(
    Map<String, dynamic> data,
  ) {
    final scheduleId = data['schedule_id'] as String;
    final userId = data['user_id'] as String;
    final attendance = data['attendance'] as bool;
    final leaveEarly = data['leave_early'] as bool;
    final lateness = data['lateness'] as bool;
    final absence = data['absence'] as bool;
    final startAt = data['start_at'] as DateTime?;
    final endAt = data['end_at'] as DateTime?;
    final updatedAt = data['updated_at'] as Timestamp?;
    final createdAt = data['created_at'] as Timestamp;

    return GroupMemberSchedule(
      scheduleId: scheduleId,
      userId: userId,
      attendance: attendance,
      leaveEarly: leaveEarly,
      lateness: lateness,
      absence: absence,
      startAt: startAt,
      endAt: endAt,
      updatedAt: updatedAt,
      createdAt: createdAt,
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

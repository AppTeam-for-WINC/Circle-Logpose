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
      Map<String, dynamic> groupMemberScheduleRef,) {
    final scheduleId = groupMemberScheduleRef['schedule_id'] as String;
    final userId = groupMemberScheduleRef['user_id'] as String;
    final attendance = groupMemberScheduleRef['attendance'] as bool;
    final leaveEarly = groupMemberScheduleRef['leave_early'] as bool;
    final lateness = groupMemberScheduleRef['lateness'] as bool;
    final absence = groupMemberScheduleRef['absence'] as bool;
    final startAt = groupMemberScheduleRef['start_at'] as DateTime?;
    final endAt = groupMemberScheduleRef['end_at'] as DateTime?;
    final updatedAt = groupMemberScheduleRef['updated_at'] as Timestamp?;
    final createdAt = groupMemberScheduleRef['created_at'] as Timestamp;

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

  ///Schedule ID
  final String scheduleId;

  ///User ID
  final String userId;

  ///Attendance
  final bool attendance;

  ///Leave early
  final bool leaveEarly;

  ///Lateness
  final bool lateness;

  ///Absence
  final bool absence;

  ///Start time
  final DateTime? startAt;

  ///End time
  final DateTime? endAt;

  ///Updateed time
  final Timestamp? updatedAt;

  ///Created time
  final Timestamp createdAt;
}

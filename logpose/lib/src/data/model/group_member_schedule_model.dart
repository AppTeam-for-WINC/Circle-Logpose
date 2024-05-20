import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/time/time_utils.dart';

class GroupMemberScheduleModel {
  const GroupMemberScheduleModel({
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

  factory GroupMemberScheduleModel.fromMap(
    Map<String, dynamic> data,
  ) {
    return GroupMemberScheduleModel(
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

import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMemberSchedule {
  const GroupMemberSchedule({
    required this.scheduleId,
    required this.userId,
    required this.attendance,
    required this.leaveEarly,
    required this.lateness,
    required this.absence,
    required this.startAt,
    required this.endAt,
    this.updatedAt,
    required this.createdAt,
  });

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
  final DateTime startAt;

  ///End time
  final DateTime endAt; 

  ///Updateed time
  final Timestamp? updatedAt;

  ///Created time
  final Timestamp createdAt;
}

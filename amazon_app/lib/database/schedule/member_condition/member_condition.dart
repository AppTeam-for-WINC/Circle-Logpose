import 'package:cloud_firestore/cloud_firestore.dart';

class MemberCondition {
  const MemberCondition({
    required this.scheduleId,
    required this.userId,
    this.documentId,
    required this.attendance,
    required this.leaveEarly,
    required this.lateness,
    required this.absence,
    required this.startAt,
    required this.endAt,
  });

  ///Document ID
  final String? documentId;

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
  final Timestamp startAt;

  ///End time
  final Timestamp endAt; 
}

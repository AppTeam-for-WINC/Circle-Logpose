import 'package:flutter/cupertino.dart';

class UserScheduleHistory {
  const UserScheduleHistory({
    this.documentId,
    required this.scheduleId,
    required this.userId,
    required this.groupId,
    required this.title,
    required this.color,
    required this.startAt,
    required this.endAt,
    this.place,
    this.detail,
    this.createdAt,
  });

  final String? documentId;
  final String scheduleId;
  final String userId;
  final String groupId;
  final String title;
  final Color color;
  final DateTime startAt;
  final DateTime endAt;
  final String? place;
  final String? detail;
  final DateTime? createdAt;
}

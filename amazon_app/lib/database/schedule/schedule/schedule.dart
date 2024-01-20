import 'package:cloud_firestore/cloud_firestore.dart';

class GroupSchedule {
  const GroupSchedule({
    required this.groupId,
    required this.title,
    required this.color,
    this.place,
    this.detail,
    required this.startAt,
    required this.endAt,
    this.updatedAt,
    required this.createdAt,
  });

  ///Group ID
  final String groupId;

  ///Title
  final String title;

  ///Color
  ///When used, it must be converted to the Color type.
  final String color;

  ///Place
  final String? place;

  ///Detail
  final String? detail;

  ///Start time
  final DateTime startAt;

  ///End time
  final DateTime endAt;

  ///Updated database time.
  final Timestamp? updatedAt;

  ///Created database time.
  final Timestamp createdAt;
}

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

  final String groupId;

  final String title;

  final String color;

  final String? place;

  final String? detail;

  final DateTime startAt;

  final DateTime endAt;

  final Timestamp? updatedAt;

  final Timestamp? createdAt;
}

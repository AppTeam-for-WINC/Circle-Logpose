import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  Schedule({
    required this.groupId,
    this.documentId,
    required this.title,
    required this.color,
    this.place,
    this.detail,
    required this.startAt,
    required this.endAt,
    this.createdAt,
  });

  ///Group ID
  final String groupId;

  ///Document ID
  final String? documentId;

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
  final Timestamp startAt;

  ///End time
  final Timestamp endAt;

  ///Created database time.
  final Timestamp? createdAt;
}

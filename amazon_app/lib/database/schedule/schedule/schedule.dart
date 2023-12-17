import 'package:flutter/material.dart';

class Schedule {
  const Schedule({
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
  final Color color;

  ///Place
  final String? place;

  ///Detail
  final String? detail;

  ///Start time
  final DateTime startAt;

  ///End time
  final DateTime endAt;

  ///Created database time.
  final DateTime? createdAt;
}

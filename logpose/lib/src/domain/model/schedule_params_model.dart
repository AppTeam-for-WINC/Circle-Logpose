import 'package:flutter/widgets.dart';

class ScheduleParams {
  ScheduleParams({
    this.groupId,
    required this.title,
    required this.color,
    required this.place,
    required this.detail,
    required this.startAt,
    required this.endAt,
  });

  final String? groupId;
  final String title;
  final Color color;
  final String place;
  final String detail;
  final DateTime startAt;
  final DateTime endAt;
}

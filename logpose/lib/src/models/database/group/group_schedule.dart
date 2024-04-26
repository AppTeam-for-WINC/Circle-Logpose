import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/time/time_utils.dart';

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

  factory GroupSchedule.fromMap(Map<String, dynamic> data) {
     ///Checked type of database variable;
      final groupId = data['group_id'] as String;
      final title = data['title'] as String;
      final color = data['color'] as String;
      final place = data['place'] as String?;
      final detail = data['detail'] as String?;
      final startAt = convertTimestampToDateTime(data['start_at']);
      final endAt = convertTimestampToDateTime(data['end_at']);
      final updatedAt = data['updated_at'] as Timestamp?;
      final createdAt = data['created_at'] as Timestamp;
      
      return GroupSchedule(
        groupId: groupId,
        title: title,
        color: color,
        place: place,
        detail: detail,
        startAt: startAt!,
        endAt: endAt!,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
  }

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

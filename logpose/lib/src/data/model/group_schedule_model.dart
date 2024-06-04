import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/time_utils.dart';

class GroupScheduleModel {
  const GroupScheduleModel({
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

  factory GroupScheduleModel.fromMap(Map<String, dynamic> data) {
    final groupId = data['group_id'] as String;
    final title = data['title'] as String;
    final color = data['color'] as String;
    final place = data['place'] as String?;
    final detail = data['detail'] as String?;
    final startAt = _convertTimestampToDateTime(data['start_at']);
    final endAt = _convertTimestampToDateTime(data['end_at']);
    final updatedAt = data['updated_at'] as Timestamp?;
    final createdAt = data['created_at'] as Timestamp?;

    return GroupScheduleModel(
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

  final String groupId;

  final String title;

  /// When used, it must be converted to the Color type.
  final String color;

  final String? place;

  final String? detail;

  final DateTime startAt;

  final DateTime endAt;

  final Timestamp? updatedAt;

  final Timestamp? createdAt;
}

DateTime? _convertTimestampToDateTime(dynamic timestamp) {
  return convertTimestampToDateTime(timestamp);
}

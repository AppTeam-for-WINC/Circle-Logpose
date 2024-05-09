import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/custom/group_schedule_and_id_model.dart';
import '../../../../models/database/group/group_schedule.dart';
import '../../../../services/database/group_schedule_controller.dart';

class FetchGroupScheduleAndId {
  FetchGroupScheduleAndId._internal();
  static final FetchGroupScheduleAndId _instance =
      FetchGroupScheduleAndId._internal();
  static FetchGroupScheduleAndId get instance => _instance;

  static Future<List<GroupScheduleAndId?>> fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  ) async {
    return Future.wait(
      scheduleIdList.whereType<String>().toList().map(_fromGroupScheduleAndId),
    );
  }

  static Future<GroupScheduleAndId?> _fromGroupScheduleAndId(
    String scheduleId,
  ) async {
    try {
      final groupSchedule = await _fetchGroupSchedule(scheduleId);
      if (groupSchedule == null) {
        return null;
      }

      return GroupScheduleAndId(
        groupSchedule: groupSchedule,
        groupScheduleId: scheduleId,
      );
    } on FirebaseException catch (e) {
      debugPrint('Error fetching Group Schedule: $e');
      return null;
    }
  }

  static Future<GroupSchedule?> _fetchGroupSchedule(String scheduleId) async {
    return GroupScheduleController.read(scheduleId);
  }
}

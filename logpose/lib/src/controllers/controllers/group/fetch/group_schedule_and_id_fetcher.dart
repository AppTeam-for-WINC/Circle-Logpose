import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/custom/group_schedule_and_id_model.dart';
import '../../../../models/database/group/group_schedule.dart';

import '../../../../server/database/group_schedule_controller.dart';

class GroupScheduleAndIdFetcher {
  const GroupScheduleAndIdFetcher();

  Future<List<GroupScheduleAndId?>> fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  ) async {
    try {
      return Future.wait(
        scheduleIdList
            .whereType<String>()
            .toList()
            .map(_fromGroupScheduleAndId),
      );
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch group schedule list. $e');
    }
  }

  Future<GroupScheduleAndId?> _fromGroupScheduleAndId(
    String scheduleId,
  ) async {
    try {
      return await _attemptToFetchGroupScheduleAndId(scheduleId);
    } on Exception catch (e) {
      debugPrint('Error: failed to fetch Group Schedule: $e');
      return null;
    }
  }

  Future<GroupScheduleAndId?> _attemptToFetchGroupScheduleAndId(
    String scheduleId,
  ) async {
    final groupSchedule = await _fetchGroupSchedule(scheduleId);
    if (groupSchedule == null) {
      return null;
    }

    return GroupScheduleAndId(
      groupSchedule: groupSchedule,
      groupScheduleId: scheduleId,
    );
  }

  Future<GroupSchedule?> _fetchGroupSchedule(String scheduleId) async {
    try {
      return await GroupScheduleController.fetch(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group schedule. ${e.message}');
    }
  }
}

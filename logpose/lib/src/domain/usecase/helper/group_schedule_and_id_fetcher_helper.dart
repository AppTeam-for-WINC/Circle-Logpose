import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_schedule_and_id_model.dart';
import '../../../models/database/group/group_schedule.dart';

import '../../providers/group/schedule/group_schedule_controller_provider.dart';

class GroupScheduleAndIdFetcherHelper {
  const GroupScheduleAndIdFetcherHelper({required this.ref});
  final Ref ref;

  Future<List<GroupScheduleAndId?>> fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  ) async {
    try {
      return Future.wait(
        scheduleIdList
            .whereType<String>()
            .toList()
            .map(fetchGroupScheduleAndId),
      );
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch group schedule list. $e');
    }
  }

  Future<GroupScheduleAndId?> fetchGroupScheduleAndId(String scheduleId) async {
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
      final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);
      return await groupScheduleRepository.fetch(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group schedule. ${e.message}');
    }
  }
}

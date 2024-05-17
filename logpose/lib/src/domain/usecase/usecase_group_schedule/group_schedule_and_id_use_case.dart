import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/group_schedule.dart';

import '../../../models/custom/group_schedule_and_id_model.dart';

import 'group_schedule_use_case.dart';

final groupScheduleAndIdUseCaseProvider =
    Provider<GroupScheduleAndIdUseCase>((ref) {
  final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);

  return GroupScheduleAndIdUseCase(
    groupScheduleUseCase: groupScheduleUseCase,
  );
});

class GroupScheduleAndIdUseCase {
  const GroupScheduleAndIdUseCase({required this.groupScheduleUseCase});

  final GroupScheduleUseCase groupScheduleUseCase;

  Future<GroupScheduleAndId?> fetchGroupScheduleAndId(String scheduleId) async {
    try {
      return await _attemptToFetchGroupScheduleAndId(scheduleId);
    } on Exception catch (e) {
      debugPrint('Error: failed to fetch Group Schedule: $e');
      return null;
    }
  }

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

  Future<GroupScheduleAndId?> _attemptToFetchGroupScheduleAndId(
    String scheduleId,
  ) async {
    final groupSchedule = await _fetchGroupSchedule(scheduleId);

    return GroupScheduleAndId(
      groupSchedule: groupSchedule,
      groupScheduleId: scheduleId,
    );
  }

  Future<GroupSchedule> _fetchGroupSchedule(String scheduleId) async {
    return groupScheduleUseCase.fetchGroupSchedule(scheduleId);
  }
}

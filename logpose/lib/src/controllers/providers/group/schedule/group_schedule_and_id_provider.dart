import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/group_schedule_and_id_model.dart';
import '../../../../services/database/group_schedule_controller.dart';

/// Watch group schedule and schedule ID.
final watchGroupScheduleAndIdProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    final scheduleIdStream =
        GroupScheduleController.watchAllScheduleId(groupId);

    await for (final scheduleIdList in scheduleIdStream) {
      final groupScheduleAndIdList = <GroupScheduleAndId?>[];

      for (final scheduleId in scheduleIdList) {
        if (scheduleId == null) {
          continue;
        }

        final groupSchedule = await GroupScheduleController.read(scheduleId);
        if (groupSchedule == null) {
          continue;
        }

        final groupScheduleAndId = GroupScheduleAndId(
          groupSchedule: groupSchedule,
          groupScheduleId: scheduleId,
        );
        groupScheduleAndIdList.add(groupScheduleAndId);
      }

      yield groupScheduleAndIdList;
    }
  },
);

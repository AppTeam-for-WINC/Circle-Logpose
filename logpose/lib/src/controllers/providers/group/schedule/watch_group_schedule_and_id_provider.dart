import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/group_schedule_and_id_model.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../controllers/group/fetch/group_schedule_and_id_fetcher.dart';

/// Watch group schedule and schedule ID.
final watchGroupScheduleAndIdProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    try {
      yield* GroupScheduleController.watchAllScheduleId(groupId).asyncMap(
        (scheduleIdList) async =>
            GroupScheduleAndIdFetcher.fetchGroupScheduleAndIdList(
          scheduleIdList,
        ),
      );
    } on Exception catch (e) {
      debugPrint('Failed to fetch group schedules: $e');
      yield [];
    }
  },
);

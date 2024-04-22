import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/group_schedule_and_id_model.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../src/group/fetch/group_schedule_and_id_fetcher.dart';

/// Watch group schedule and schedule ID.
final watchGroupScheduleAndIdProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    yield* GroupScheduleController.watchAllScheduleId(groupId)
        .map((scheduleIdList) async {
      return Future.wait(
        await GroupScheduleAndIdFetcher.fromMap(scheduleIdList),
      );
    }).asyncMap((event) => event);
  },
);

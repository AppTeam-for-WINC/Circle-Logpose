import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_profile_and_schedule_and_id_model.dart';

import '../../controllers/group/listen/group_and_schedule_and_id_list_listener.dart';

// final watchGroupAndScheduleAndIdProvider =
//     StreamProvider<List<GroupProfileAndScheduleAndId>>((ref) async* {
//   yield* GroupAndScheduleAndIdListListener.listenGroupAndScheduleAndIdList();
// });

final watchGroupAndScheduleAndIdProvider =
    StreamProvider<List<GroupProfileAndScheduleAndId>>((ref) async* {
  final stream =
      GroupAndScheduleAndIdListListener.listenGroupAndScheduleAndIdList();
  await for (final snapshot in stream) {
    // // 日付で昇順ソート
    snapshot.sort(
      (a, b) => a.groupSchedule.startAt.compareTo(b.groupSchedule.startAt),
    );
    yield snapshot;

    // グループ名かつ日付で昇順ソート
    snapshot.sort((a, b) {
      final result = a.groupProfile.name.compareTo(b.groupProfile.name);
      if (result != 0) {
        return result;
      }
      return a.groupSchedule.startAt.compareTo(b.groupSchedule.startAt);
    });
    yield snapshot;
  }
});

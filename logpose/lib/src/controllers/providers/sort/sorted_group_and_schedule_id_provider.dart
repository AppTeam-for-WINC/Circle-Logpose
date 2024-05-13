import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_profile_and_schedule_and_id_model.dart';

import '../../controllers/group/listen/group_and_schedule_and_id_list_listener.dart';
import 'sort_option_provider.dart';

final sortedGroupAndScheduleAndIdProvider =
    StreamProvider.autoDispose<List<GroupProfileAndScheduleAndId>>(
        (ref) async* {
  final stream = const GroupAndScheduleAndIdListListener()
      .listenGroupAndScheduleAndIdList();
  final sortOption = ref.watch(sortOptionProvider);

  await for (final snapshot in stream) {
    // 日付で昇順ソート
    if (sortOption == SortOption.byDate) {
      snapshot.sort(
        (a, b) => a.groupSchedule.startAt.compareTo(b.groupSchedule.startAt),
      );

      // グループ名かつ日付で昇順ソート
    } else if (sortOption == SortOption.byGroupNameAndDate) {
      snapshot.sort((a, b) {
        final result = a.groupProfile.name.compareTo(b.groupProfile.name);
        return result != 0
            ? result
            : a.groupSchedule.startAt.compareTo(b.groupSchedule.startAt);
      });
    }
    yield snapshot;
  }
});

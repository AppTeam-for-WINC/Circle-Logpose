import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/group_profile_and_schedule_and_id_model.dart';
import '../../providers/sort/sort_option_provider.dart';
import 'group_and_schedule_and_id_list_listen_use_case.dart';
import 'helper/group_and_schedule_and_id_sorted_helper.dart';

final groupAndScheduleSortedStreamUseCaseProvider =
    Provider<GroupAndScheduleSortedStreamUseCase>(
  (ref) {
    final groupAndScheduleAndIdListListenUseCase =
        ref.read(groupAndScheduleAndIdListListenUseCaseProvider);
    final groupAndScheduleSorter =
        ref.read(groupAndScheduleAndIdSortedHelperProvider);

    return GroupAndScheduleSortedStreamUseCase(
      groupAndScheduleAndIdListListenUseCase:
          groupAndScheduleAndIdListListenUseCase,
      groupAndScheduleSorter: groupAndScheduleSorter,
    );
  },
);

class GroupAndScheduleSortedStreamUseCase {
  const GroupAndScheduleSortedStreamUseCase({
    required this.groupAndScheduleAndIdListListenUseCase,
    required this.groupAndScheduleSorter,
  });

  final GroupAndScheduleAndIdListListenUseCase
      groupAndScheduleAndIdListListenUseCase;
  final GroupAndScheduleAndIdSortedHelper groupAndScheduleSorter;

  Stream<List<GroupProfileAndScheduleAndId>> sortedGroupAndScheduleStream(
    SortOption sortOption,
  ) async* {
    final stream = groupAndScheduleAndIdListListenUseCase
        .listenGroupAndScheduleAndIdList();
    await for (final snapshot in stream) {
      final sortedSnapshot = groupAndScheduleSorter.sortGroupAndScheduleByTerm(
        snapshot,
        sortOption,
      );
      yield sortedSnapshot;
    }
  }
}

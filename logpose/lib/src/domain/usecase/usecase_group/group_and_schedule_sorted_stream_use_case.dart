import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/group/i_group_and_schedule_and_id_list_listen_use_case.dart';
import '../../interface/group/i_group_and_schedule_sorted_listen_use_case.dart';
import '../../model/group_profile_and_schedule_and_id_model.dart';
import '../../providers/sort/sort_option_provider.dart';
import 'group_and_schedule_and_id_list_listen_use_case.dart';
import 'helper/group_and_schedule_and_id_sorted_helper.dart';

final groupAndScheduleSortedListenUseCaseProvider =
    Provider<IGroupAndScheduleSortedListenUseCase>(
  (ref) {
    final groupAndScheduleAndIdListListenUseCase =
        ref.read(groupAndScheduleAndIdListListenUseCaseProvider);
    final groupAndScheduleSorter =
        ref.read(groupAndScheduleAndIdSortedHelperProvider);

    return GroupAndScheduleSortedListenUseCase(
      groupAndScheduleAndIdListListenUseCase:
          groupAndScheduleAndIdListListenUseCase,
      groupAndScheduleSorter: groupAndScheduleSorter,
    );
  },
);

class GroupAndScheduleSortedListenUseCase
    implements IGroupAndScheduleSortedListenUseCase {
  const GroupAndScheduleSortedListenUseCase({
    required this.groupAndScheduleAndIdListListenUseCase,
    required this.groupAndScheduleSorter,
  });

  final IGroupAndScheduleAndIdListListenUseCase
      groupAndScheduleAndIdListListenUseCase;
  final GroupAndScheduleAndIdSortedHelper groupAndScheduleSorter;

  @override
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

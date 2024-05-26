import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../presentation/providers/sort/sort_option_provider.dart';

import '../../../model/group_profile_and_schedule_and_id_model.dart';

final groupAndScheduleAndIdSortedHelperProvider =
    Provider<GroupAndScheduleAndIdSortedHelper>(
  (ref) => const GroupAndScheduleAndIdSortedHelper(),
);

class GroupAndScheduleAndIdSortedHelper {
  const GroupAndScheduleAndIdSortedHelper();

  List<GroupProfileAndScheduleAndId> sortGroupAndScheduleByTerm(
    List<GroupProfileAndScheduleAndId> list,
    SortOption sortOption,
  ) {
    if (sortOption == SortOption.byDate) {
      return _sortedByDate(list);
    } else if (sortOption == SortOption.byGroupNameAndDate) {
      return _sortedByGroupName(list);
    }
    return list;
  }

  List<GroupProfileAndScheduleAndId> _sortedByDate(
    List<GroupProfileAndScheduleAndId> list,
  ) {
    list.sort(
      (a, b) => a.groupSchedule.startAt.compareTo(b.groupSchedule.startAt),
    );
    return list;
  }

  List<GroupProfileAndScheduleAndId> _sortedByGroupName(
    List<GroupProfileAndScheduleAndId> list,
  ) {
    list.sort((a, b) {
      final result = a.groupProfile.name.compareTo(b.groupProfile.name);
      return result != 0
          ? result
          : a.groupSchedule.startAt.compareTo(b.groupSchedule.startAt);
    });
    return list;
  }
}

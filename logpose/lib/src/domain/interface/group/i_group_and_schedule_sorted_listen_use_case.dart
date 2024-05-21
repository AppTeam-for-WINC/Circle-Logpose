// ignore_for_file: one_member_abstracts

import '../../model/group_profile_and_schedule_and_id_model.dart';
import '../../providers/sort/sort_option_provider.dart';

abstract class IGroupAndScheduleSortedListenUseCase {
  Stream<List<GroupProfileAndScheduleAndId>> sortedGroupAndScheduleStream(
    SortOption sortOption,
  );
}

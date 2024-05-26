// ignore_for_file: one_member_abstracts

import '../../../presentation/providers/sort/sort_option_provider.dart';
import '../../model/group_profile_and_schedule_and_id_model.dart';

abstract class IGroupAndScheduleSortedListenUseCase {
  Stream<List<GroupProfileAndScheduleAndId>> sortedGroupAndScheduleStream(
    SortOption sortOption,
  );
}

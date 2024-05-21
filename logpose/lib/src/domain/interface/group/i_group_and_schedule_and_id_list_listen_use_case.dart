// ignore_for_file: one_member_abstracts

import '../../model/group_profile_and_schedule_and_id_model.dart';

abstract class IGroupAndScheduleAndIdListListenUseCase {
  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList();
}

// ignore_for_file: one_member_abstracts

import '../../model/group_schedule_and_id_model.dart';

abstract class IGroupScheduleAndIdListListenUseCase {
  Stream<List<GroupScheduleAndId?>> listenAllGroupScheduleAndIdList(
    String groupId,
  );
}

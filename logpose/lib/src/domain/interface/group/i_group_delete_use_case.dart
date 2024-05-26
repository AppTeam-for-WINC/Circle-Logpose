// ignore_for_file: one_member_abstracts

import '../../model/group_id_and_schedule_id_and_member_list_model.dart';

abstract class IGroupDeleteUseCase {
  Future<void> deleteGroup(GroupIdAndScheduleIdAndMemberList groupData);
}

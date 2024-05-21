// ignore_for_file: one_member_abstracts

import '../../entity/group_member_schedule.dart';

abstract class IGroupMemberScheduleInitUseCase {
  Future<GroupMemberSchedule> initMemberSchedule(String groupScheduleId);
}

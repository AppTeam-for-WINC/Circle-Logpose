// ignore_for_file: one_member_abstracts

import '../../entity/group_schedule.dart';

abstract class IGroupScheduleUseCase {
  Future<GroupSchedule> fetchGroupSchedule(String groupScheduleId);
}

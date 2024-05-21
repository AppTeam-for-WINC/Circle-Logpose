// ignore_for_file: one_member_abstracts

import '../../entity/group_member_schedule.dart';

abstract class IGroupMemberScheduleListenResponsedUseCase {
  Stream<GroupMemberSchedule?> listenResponsedGroupMemberSchedule(
    String scheduleId,
    String accountId,
  );
}

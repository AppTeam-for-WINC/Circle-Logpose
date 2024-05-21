import '../../entity/group_member_schedule.dart';

abstract class IGroupMemberScheduleUseCase {
  Future<GroupMemberSchedule> fetchMemberSchedule(String memberScheduleId);

  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId(
    String userDocId,
    String scheduleId,
  );
}

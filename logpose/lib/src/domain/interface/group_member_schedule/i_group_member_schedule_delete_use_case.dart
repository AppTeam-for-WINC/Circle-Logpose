import '../../entity/user_profile.dart';

abstract class IGroupMemberScheduleDeleteUseCase {
  Future<void> deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  );

  Future<void> deleteMemberSchedule(String memberScheduleId);

  Future<void> deleteSchedulesForMemberInGroup(String membershipId);
}

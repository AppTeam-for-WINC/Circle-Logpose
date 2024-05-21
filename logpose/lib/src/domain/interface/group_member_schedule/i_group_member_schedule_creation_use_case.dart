abstract class IGroupMemberScheduleCreationUseCase {
  Future<void> createMemberSchedule(String scheduleId, String userId);

  Future<void> createAllMemberSchedule(String groupId, String scheduleId);
}

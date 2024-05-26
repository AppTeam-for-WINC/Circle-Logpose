abstract class IGroupMemberScheduleIdUseCase {
  Future<String?> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  );

  Future<String?> fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userId,
  );
}

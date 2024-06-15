abstract class IGroupMemberScheduleIdUseCase {
  Future<String?> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  );

  Future<List<String>?> fetchMemberScheduleIdListWithUserId(String userId);

  Future<String?> fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userId,
  );
}

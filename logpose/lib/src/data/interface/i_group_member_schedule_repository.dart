import '../../domain/entity/group_member_schedule.dart';

abstract class IGroupMemberScheduleRepository {
  Future<void> createMemberSchedule({
    required String scheduleId,
    required String userId,
    bool attendance = false,
    bool leaveEarly = false,
    bool lateness = false,
    bool absence = false,
    DateTime? startAt,
    DateTime? endAt,
  });

  Future<GroupMemberSchedule?> fetchMemberSchedule(String docId);

  Future<String> fetchDocIdWithScheduleIdAndUserId({
    required String scheduleId,
    required String userDocId,
  });

  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId({
    required String userDocId,
    required String scheduleId,
  });

  Future<List<GroupMemberSchedule?>> fetchAllGroupMemberSchedule(
    String scheduleId,
    String userDocId,
  );

  Future<String?> fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userDocId,
  );

  Future<List<GroupMemberSchedule?>> fetchAllMemberScheduleByTerm(
    String scheduleId,
    String userDocId,
  );

  Future<void> update({
    required String docId,
    bool? attendance,
    bool? leaveEarly,
    bool? lateness,
    bool? absence,
    DateTime? startAt,
    DateTime? endAt,
  });

  Future<void> delete(String docId);
}

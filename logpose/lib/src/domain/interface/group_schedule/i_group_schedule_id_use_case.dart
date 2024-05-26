// ignore_for_file: one_member_abstracts

abstract class IGroupScheduleIdUseCase {
  Future<List<String?>> fetchAllGroupScheduleId(String groupId);
}

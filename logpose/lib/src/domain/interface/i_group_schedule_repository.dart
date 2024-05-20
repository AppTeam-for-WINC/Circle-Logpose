import '../entity/group_schedule.dart';

abstract class IGroupScheduleRepository {
  Future<String> createAndRetrieveScheduleId({
    required String groupId,
    required String title,
    required String color,
    String? place,
    String? detail,
    required DateTime startAt,
    required DateTime endAt,
  });

  Stream<List<GroupSchedule?>> fetchAllGroupSchedule(String groupId);

  Stream<List<String?>> listenAllScheduleId(String groupId);

  Future<List<String?>> fetchAllGroupScheduleId(String groupId);

  Future<GroupSchedule> fetchGroupSchedule(String docId);

  Future<String> fetchGroupId(String docId);

  Future<void> update({
    required String docId,
    required String groupId,
    required String title,
    required String? place,
    required String color,
    required String? detail,
    required DateTime startAt,
    required DateTime endAt,
  });

  Future<void> delete(String docId);
}

import '../../model/group_schedule_and_id_model.dart';

abstract class IGroupScheduleAndIdUseCase {
  Future<GroupScheduleAndId?> fetchGroupScheduleAndId(String scheduleId);

    Future<List<GroupScheduleAndId?>> fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  );
}

import '../../../../models/group/group_schedule_and_id_model.dart';
import '../../../../services/database/group_schedule_controller.dart';

class GroupScheduleAndIdFetcher {
  GroupScheduleAndIdFetcher._internal();
  static final GroupScheduleAndIdFetcher _instance =
      GroupScheduleAndIdFetcher._internal();
  static GroupScheduleAndIdFetcher get instance => _instance;

  static Future<List<Future<GroupScheduleAndId?>>> fromMap(
    List<String?> scheduleIdList,
  ) async {
    return scheduleIdList.map((scheduleId) async {
      if (scheduleId == null) {
        return null;
      }

      return _fromGroupScheduleAndId(scheduleId);
    }).toList();
  }

  static Future<GroupScheduleAndId?> _fromGroupScheduleAndId(
    String scheduleId,
  ) async {
    final groupSchedule = await GroupScheduleController.read(scheduleId);
    if (groupSchedule == null) {
      return null;
    }

    return GroupScheduleAndId(
      groupSchedule: groupSchedule,
      groupScheduleId: scheduleId,
    );
  }
}

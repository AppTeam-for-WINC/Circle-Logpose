import '../../../services/database/member_schedule_controller.dart';

class UpdateGroupMemberSchedule {
  UpdateGroupMemberSchedule._internal();
  static final UpdateGroupMemberSchedule _instance =
      UpdateGroupMemberSchedule._internal();
  static UpdateGroupMemberSchedule get instance => _instance;

  Future<void> setJoinTime(
    String docId,
    DateTime? startAt,
    DateTime? endAt,
  ) async {
    await GroupMemberScheduleController.update(
      docId: docId,
      startAt: startAt,
      endAt: endAt,
    );
  }
}

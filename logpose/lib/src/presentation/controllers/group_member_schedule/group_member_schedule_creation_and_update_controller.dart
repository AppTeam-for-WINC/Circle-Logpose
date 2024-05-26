import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_member_schedule_facade.dart';
import '../../../domain/model/schedule_response_params_model.dart';

final groupMemberScheduleCreationAndUpdateControllerProvider =
    Provider<GroupMemberScheduleCreationAndUpdateController>(
  GroupMemberScheduleCreationAndUpdateController.new,
);

class GroupMemberScheduleCreationAndUpdateController {
  GroupMemberScheduleCreationAndUpdateController(this.ref);

  final Ref ref;

  Future<void> createMemberSchedule(String scheduleId, String userId) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    await groupMemberScheduleFacade.createMemberSchedule(
      scheduleId,
      userId,
    );
  }

  Future<void> createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    await groupMemberScheduleFacade.createAllMemberSchedule(
      groupId,
      scheduleId,
    );
  }

  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.updateStartAt(memberScheduleId, startAt);
  }

  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.updateEndAt(memberScheduleId, endAt);
  }

  Future<void> updateResponse(ScheduleResponseParams scheduleParams) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.updateResponse(scheduleParams);
  }
}

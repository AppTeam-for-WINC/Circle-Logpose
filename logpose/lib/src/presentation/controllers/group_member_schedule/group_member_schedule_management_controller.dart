import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_member_schedule_facade.dart';

import '../../../domain/entity/group_member_schedule.dart';

final groupMemberScheduleManagementControllerProvider =
    Provider<GroupMemberScheduleManagementController>(
  GroupMemberScheduleManagementController.new,
);

class GroupMemberScheduleManagementController {
  GroupMemberScheduleManagementController(this.ref);

  final Ref ref;

  Future<String?> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  ) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.fetchMemberScheduleId(
      groupScheduleId,
      userDocId,
    );
  }

  Future<GroupMemberSchedule> fetchMemberSchedule(
    String memberScheduleId,
  ) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.fetchMemberSchedule(memberScheduleId);
  }

  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId(
    String userDocId,
    String scheduleId,
  ) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId,
      scheduleId,
    );
  }

  Future<GroupMemberSchedule?> initMemberSchedule(
    String groupScheduleId,
  ) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.initMemberSchedule(groupScheduleId);
  }

  Stream<GroupMemberSchedule?> listenResponsedGroupMemberSchedule(
    String scheduleId,
    String accountId,
  ) {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    return groupMemberScheduleFacade.listenResponsedGroupMemberSchedule(
      scheduleId,
      accountId,
    );
  }
}

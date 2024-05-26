import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_schedule_facade.dart';

import '../../../domain/entity/group_schedule.dart';

import '../../../domain/model/group_schedule_and_id_model.dart';

final groupScheduleManagementControllerProvider =
    Provider<GroupScheduleManagementController>(
  GroupScheduleManagementController.new,
);

class GroupScheduleManagementController {
  GroupScheduleManagementController(this.ref);

  final Ref ref;

  Future<List<String?>> fetchAllGroupScheduleId(String groupId) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.fetchAllGroupScheduleId(groupId);
  }

  Future<GroupSchedule> fetchGroupSchedule(String groupScheduleId) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.fetchGroupSchedule(groupScheduleId);
  }

  Future<GroupScheduleAndId?> fetchGroupScheduleAndId(String scheduleId) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.fetchGroupScheduleAndId(scheduleId);
  }

  Future<List<GroupScheduleAndId?>> fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  ) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.fetchGroupScheduleAndIdList(scheduleIdList);
  }

  Future<String> fetchGroupIdWithScheduleId(String scheduleId) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.fetchGroupIdWithScheduleId(scheduleId);
  }

  Stream<List<String?>> listenAllScheduleId(String groupId) async* {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    yield* groupScheduleFacade.listenAllScheduleId(groupId);
  }

  Stream<List<GroupScheduleAndId?>> listenAllGroupScheduleAndIdList(
    String groupId,
  ) {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.listenAllGroupScheduleAndIdList(groupId);
  }
}

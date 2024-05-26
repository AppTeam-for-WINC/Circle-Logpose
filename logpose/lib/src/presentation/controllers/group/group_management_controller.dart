import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_facade.dart';

import '../../../domain/entity/group_profile.dart';

import '../../../domain/model/group_and_id_model.dart';
import '../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../providers/sort/sort_option_provider.dart';

final groupManagementControllerProvider = Provider<GroupManagementController>(
  GroupManagementController.new,
);

class GroupManagementController {
  GroupManagementController(this.ref);

  final Ref ref;

  Future<GroupProfile> fetchGroup(String groupId) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.fetchGroup(groupId);
  }

  Future<GroupAndId> fetchGroupAndId(String groupId) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.fetchGroupAndId(groupId);
  }

  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.fetchGroupAndIdList(groupIdList);
  }

  Stream<GroupAndId?> listenGroupAndId(String groupId) {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.listenGroupAndId(groupId);
  }

  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    final groupFacade = ref.read(groupFacadeProvider);
    yield* groupFacade.listenGroupAndScheduleAndIdList();
  }

  Stream<List<GroupProfileAndScheduleAndId>> sortedGroupAndScheduleStream(
    SortOption sortOption,
  ) {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.sortedGroupAndScheduleStream(sortOption);
  }
}

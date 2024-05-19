import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/group_profile.dart';

import '../../model/group_and_id_model.dart';
import '../../model/group_creator_params_model.dart';
import '../../model/group_id_and_schedule_id_and_member_list_model.dart';
import '../../model/group_profile_and_schedule_and_id_model.dart';
import '../../model/group_setting_params_model.dart';

import '../../providers/sort/sort_option_provider.dart';

import '../usecase_group/group_and_id_listen_use_case.dart';
import '../usecase_group/group_and_id_use_case.dart';
import '../usecase_group/group_and_schedule_and_id_list_listen_use_case.dart';
import '../usecase_group/group_and_schedule_sorted_stream_use_case.dart';
import '../usecase_group/group_creation_use_case.dart';
import '../usecase_group/group_delete_use_case.dart';
import '../usecase_group/group_update_use_case.dart';
import '../usecase_group/group_use_case.dart';

final groupFacadeProvider = Provider<GroupFacade>(
  (ref) => GroupFacade(ref: ref),
);

class GroupFacade {
  GroupFacade({required this.ref})
      : _groupCreationUseCase = ref.read(groupCreationUseCaseProvider),
        _groupUseCase = ref.read(groupUseCaseProvider),
        _groupAndIdUseCase = ref.read(groupAndIdUseCaseProvider),
        _groupAndIdListenUseCase = ref.read(groupAndIdListenUseCaseProvider),
        _groupAndScheduleAndIdListListenUseCase =
            ref.read(groupAndScheduleAndIdListListenUseCaseProvider),
        _groupUpdateUseCase = ref.read(groupUpdateUseCaseProvider),
        _groupDeleteUseCase = ref.read(groupDeleteUseCaseProvider),
        _groupAndScheduleSortedUseCase =
            ref.read(groupAndScheduleSortedStreamUseCaseProvider);

  final Ref ref;
  final GroupCreationUseCase _groupCreationUseCase;
  final GroupUseCase _groupUseCase;
  final GroupAndIdUseCase _groupAndIdUseCase;
  final GroupAndIdListenUseCase _groupAndIdListenUseCase;
  final GroupAndScheduleAndIdListListenUseCase
      _groupAndScheduleAndIdListListenUseCase;
  final GroupUpdateUseCase _groupUpdateUseCase;
  final GroupDeleteUseCase _groupDeleteUseCase;
  final GroupAndScheduleSortedStreamUseCase _groupAndScheduleSortedUseCase;

  Future<String?> createGroup(GroupCreatorParams groupData) async {
    return _groupCreationUseCase.createGroup(groupData);
  }

  Future<GroupProfile> fetchGroup(String groupId) async {
    return _groupUseCase.fetchGroup(groupId);
  }

  Future<GroupAndId> fetchGroupAndId(String groupId) async {
    return _groupAndIdUseCase.fetchGroupAndId(groupId);
  }

  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList) async {
    return _groupAndIdUseCase.fetchGroupAndIdList(groupIdList);
  }

  Stream<GroupAndId?> listenGroupAndId(String groupId) {
    return _groupAndIdListenUseCase.listenGroupAndId(groupId);
  }

  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    yield* _groupAndScheduleAndIdListListenUseCase
        .listenGroupAndScheduleAndIdList();
  }

  Future<String?> updateGroup(GroupSettingParams groupData) async {
    return _groupUpdateUseCase.updateGroup(groupData);
  }

  Future<void> deleteGroup(GroupIdAndScheduleIdAndMemberList groupData) async {
    await _groupDeleteUseCase.deleteGroup(groupData);
  }

  Stream<List<GroupProfileAndScheduleAndId>> sortedGroupAndScheduleStream(
    SortOption sortOption,
  ) {
    return _groupAndScheduleSortedUseCase.sortedGroupAndScheduleStream(
      sortOption,
    );
  }
}

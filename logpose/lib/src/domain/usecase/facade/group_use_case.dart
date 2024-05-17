import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/group_profile.dart';

import '../../../models/custom/group_and_id_model.dart';
import '../../../models/custom/group_creator_params_model.dart';
import '../../../models/custom/group_id_and_schedule_id_and_member_list_model.dart';
import '../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import '../../../models/custom/group_setting_params_model.dart';

import '../usecase_group/group_and_id_use_case.dart';
import '../usecase_group/group_and_schedule_and_id_list_listen_use_case.dart';
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
        _groupAndScheduleAndIdListListenUseCase =
            ref.read(groupAndScheduleAndIdListListenUseCaseProvider),
        _groupUpdateUseCase = ref.read(groupUpdateUseCaseProvider),
        _groupDeleteUseCase = ref.read(groupDeleteUseCaseProvider);

  final Ref ref;
  final GroupCreationUseCase _groupCreationUseCase;
  final GroupUseCase _groupUseCase;
  final GroupAndIdUseCase _groupAndIdUseCase;
  final GroupAndScheduleAndIdListListenUseCase
      _groupAndScheduleAndIdListListenUseCase;
  final GroupUpdateUseCase _groupUpdateUseCase;
  final GroupDeleteUseCase _groupDeleteUseCase;

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
}

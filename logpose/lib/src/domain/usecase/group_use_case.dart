import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom/group_and_id_model.dart';
import '../../models/custom/group_creator_params_model.dart';
import '../../models/custom/group_id_and_schedule_id_and_member_list_model.dart';
import '../../models/custom/group_profile_and_schedule_and_id_model.dart';
import '../../models/custom/group_setting_params_model.dart';
import '../../models/database/group/group_profile.dart';

import '../providers/group/group/group_and_id_fetcher_helper_provider.dart';
import '../providers/group/group/group_and_schedule_and_id_list_listen_helper_provider.dart';
import '../providers/group/group/group_controller_provider.dart';
import '../providers/group/group/group_creation_helper_provider.dart';
import '../providers/group/group/group_update_helper_provider.dart';

import 'helper/group_and_id_fetcher_helper.dart';
import 'helper/group_and_schedule_and_id_list_listener.dart';
import 'helper/group_creation_helper.dart';
import 'helper/group_delete_helper.dart';
import 'helper/group_update_helper.dart';

final groupUseCaseProvider = Provider<GroupUseCase>(
  (ref) => GroupUseCase(ref: ref),
);

class GroupUseCase {
  GroupUseCase({required this.ref})
      : _groupCreationHelper = ref.read(groupCreationHelperProvider),
        _groupAndIdFetcherHelper = ref.read(groupAndIdFetcherHelperProvider),
        _groupAndScheduleAndIdListListenHelper =
            ref.read(groupAndScheduleAndIdListListenHelperProvider),
        _groupUpdateHelper = ref.read(groupUpdateHelperProvider),
        _groupDeleteHelper = ref.read(groupDeleteHelperProvider);

  final Ref ref;
  final GroupCreationHelper _groupCreationHelper;
  final GroupAndIdFetcherHelper _groupAndIdFetcherHelper;
  final GroupAndScheduleAndIdListListenHelper
      _groupAndScheduleAndIdListListenHelper;
  final GroupUpdateHelper _groupUpdateHelper;
  final GroupDeleteHelper _groupDeleteHelper;

  Future<String?> createGroup(GroupCreatorParams groupData) async {
    return _groupCreationHelper.createGroup(groupData);
  }

  Future<GroupProfile> fetchGroup(String groupId) async {
    try {
      final groupRepository = ref.read(groupRepositoryProvider);
      return await groupRepository.fetchGroup(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group. ${e.message}');
    }
  }

  Future<List<GroupAndId>> fetchGroupAndIdList(
    List<String> groupIdList,
  ) async {
    return _groupAndIdFetcherHelper.fetchGroupAndIdList(groupIdList);
  }

  Future<GroupAndId> fetchGroupAndId(String groupId) async {
    return _groupAndIdFetcherHelper.fetchGroupAndId(groupId);
  }

  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    yield* _groupAndScheduleAndIdListListenHelper
        .listenGroupAndScheduleAndIdList();
  }

  Future<String?> updateGroup(GroupSettingParams groupData) async {
    return _groupUpdateHelper.updateGroup(groupData);
  }

  Future<void> deleteGroup(GroupIdAndScheduleIdAndMemberList groupData) async {
    await _groupDeleteHelper.deleteGroup(groupData);
  }
}

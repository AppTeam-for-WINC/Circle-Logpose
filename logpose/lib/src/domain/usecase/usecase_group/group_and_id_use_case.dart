import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/group_profile.dart';

import '../../interface/group/i_group_and_id_use_case.dart';
import '../../interface/group/i_group_use_case.dart';

import '../../model/group_and_id_model.dart';

import 'group_use_case.dart';

final groupAndIdUseCaseProvider = Provider<IGroupAndIdUseCase>((ref) {
  final groupUseCase = ref.read(groupUseCaseProvider);

  return GroupAndIdUseCase(groupUseCase: groupUseCase);
});

class GroupAndIdUseCase implements IGroupAndIdUseCase {
  const GroupAndIdUseCase({required this.groupUseCase});

  final IGroupUseCase groupUseCase;

  @override
  Future<GroupAndId> fetchGroupAndId(String groupId) async {
    try {
      return await _attemptToFetchGroupAndId(groupId);
    } on Exception catch (e) {
      throw Exception('Failed to from GroupAndId. $e');
    }
  }

  @override
  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList) async {
    try {
      /// tear-off system of Dart. (groupId) => fromGroupAndId(groupId)
      return await Future.wait(groupIdList.map(fetchGroupAndId).toList());
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch group data. $e');
    }
  }

  Future<GroupAndId> _attemptToFetchGroupAndId(String groupId) async {
    final groupProfile = await _fetchGroup(groupId);

    return GroupAndId(
      groupProfile: groupProfile,
      groupId: groupId,
    );
  }

  Future<GroupProfile> _fetchGroup(String groupId) async {
    return groupUseCase.fetchGroup(groupId);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_and_id_model.dart';
import '../../../models/database/group/group_profile.dart';

import '../group_use_case.dart';

class GroupAndIdFetcherHelper {
  const GroupAndIdFetcherHelper({required this.ref});
  final Ref ref;

  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList) async {
    try {
      /// tear-off system of Dart. (groupId) => fromGroupAndId(groupId)
      return await Future.wait(groupIdList.map(fetchGroupAndId).toList());
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch group data. $e');
    }
  }

  Future<GroupAndId> fetchGroupAndId(String groupId) async {
    try {
      return await _attemptToFetchGroupAndId(groupId);
    } on Exception catch (e) {
      throw Exception('Failed to from GroupAndId. $e');
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
    final groupUseCase = ref.read(groupUseCaseProvider);
    return groupUseCase.fetchGroup(groupId);
  }
}

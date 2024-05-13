import 'package:firebase_core/firebase_core.dart';

import '../../../../models/custom/group_and_id_model.dart';
import '../../../../models/database/group/group_profile.dart';

import '../../../../server/database/group_controller.dart';

/// Used with fetch_group_and_id_provider, fetch_group_and_id_list_provider.
class GroupAndIdFetcher {
  const GroupAndIdFetcher();

  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList) {
    try {
      /// tear-off system of Dart. (groupId) => fromGroupAndId(groupId)
      return Future.wait(groupIdList.map(fetchGroupAndId).toList());
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
    final groupProfile = await _fetchGroupProfile(groupId);
    
    return GroupAndId(
      groupProfile: groupProfile,
      groupId: groupId,
    );
  }

  Future<GroupProfile> _fetchGroupProfile(String groupId) async {
    try {
      return await GroupController.fetch(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. ${e.message}');
    }
  }
}

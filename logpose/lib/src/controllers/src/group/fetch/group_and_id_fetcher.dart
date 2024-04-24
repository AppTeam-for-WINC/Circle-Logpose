import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/group/database/group_profile.dart';
import '../../../../models/group/group_and_id_model.dart';
import '../../../../services/database/group_controller.dart';

class GroupAndIdFetcher {
  GroupAndIdFetcher._internal();
  static final GroupAndIdFetcher _instance = GroupAndIdFetcher._internal();
  static GroupAndIdFetcher get instance => _instance;

  static Future<List<GroupAndId>> fetchGroupAndIdList(
    List<String> groupIdList,
  ) {
    /// tear-off system of Dart. (groupId) => fromGroupAndId(groupId)
    return Future.wait(groupIdList.map(fetchGroupAndId).toList());
  }

  static Future<GroupAndId> fetchGroupAndId(String groupId) async {
    try {
      final groupProfile = await _readGroupProfile(groupId);
      if (groupProfile == null) {
        debugPrint('Failed to fetch Group profile.');
        throw Exception('Group profile not found for ID: $groupId');
      }

      return GroupAndId(
        groupProfile: groupProfile,
        groupId: groupId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Failed to from GroupAndId. $e');
    }
  }

  static Future<GroupProfile?> _readGroupProfile(String groupId) async {
    return GroupController.read(groupId);
  }
}

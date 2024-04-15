import '../../../../models/group/group_and_id_model.dart';
import '../../../../services/database/group_controller.dart';

class GroupProfileFetcher {
  GroupProfileFetcher._internal();
  static final GroupProfileFetcher _instance = GroupProfileFetcher._internal();
  static GroupProfileFetcher get instance => _instance;

  static List<Future<GroupAndId?>> fromMap(List<String> groupIdList) {
    /// tear-off system of Dart. (groupId) => fromGroupAndId(groupId)
    return groupIdList.map(fromGroupAndId).toList();
  }

  static Future<GroupAndId?> fromGroupAndId(String groupId) async {
    final groupProfile = await GroupController.read(groupId);
    if (groupProfile == null) {
      return null;
    }
    return GroupAndId(
      groupProfile: groupProfile,
      groupId: groupId,
    );
  }
}

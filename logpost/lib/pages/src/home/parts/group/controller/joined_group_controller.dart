import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../database/auth/auth_controller.dart';
import '../../../../../../database/group/group/group.dart';
import '../../../../../../database/group/group/group_controller.dart';
import '../../../../../../database/group/membership/group_membership_controller.dart';

// このコードでは、BLoCパターンの構造をしたRxDartを使用している。以下リンクは参考サイトである。
// https://qiita.com/tetsufe/items/521014ddc59f8d1df581

class GroupWithId {
  GroupWithId({required this.groupProfile, required this.groupId});
  final GroupProfile groupProfile;
  final String groupId;
}

final readJoinedGroupsProfileProvider = StreamProvider<List<String>>(
  (ref) async* {
    final userDocId = await AuthController.getCurrentUserId();
    if (userDocId == null) {
      throw Exception('User not login.');
    }

    final membershipsStream =
        GroupMembershipController.readAllWithUserId(userDocId);

    await for (final memberships in membershipsStream) {
      yield memberships.map((e) => e?.groupId).whereType<String>().toList();
    }
  },
);

final readGroupWithIdProvider =
    StreamProvider.family<GroupWithId, String>((ref, groupId) async* {
  final groupProfileStream = GroupController.read(groupId);
  await for (final groupProfile in groupProfileStream) {
    if (groupProfile == null) {
      continue;
    }
    yield GroupWithId(groupProfile: groupProfile, groupId: groupId);
  }
});

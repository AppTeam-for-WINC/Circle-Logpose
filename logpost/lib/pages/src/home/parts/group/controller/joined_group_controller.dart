import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rxdart/rxdart.dart';

import '../../../../../../database/auth/auth_controller.dart';
import '../../../../../../database/group/group/group.dart';
import '../../../../../../database/group/group/group_controller.dart';
import '../../../../../../database/group/membership/group_membership_controller.dart';

// このコードでは、BLoCパターンの構造をしたRxDartを使用している。以下リンクは参考サイトである。
// https://qiita.com/tetsufe/items/521014ddc59f8d1df581

class GroupWithId {
  GroupWithId({required this.group, required this.groupId});
  final GroupProfile group;
  final String groupId;
}

final readJoinedGroupsProfileProvider = StreamProvider<List<GroupWithId>>(
  (ref) async* {
    final userDocId = await AuthController.getCurrentUserId();
    if (userDocId == null) {
      throw Exception('User not login.');
    }

    final membershipsStream =
        GroupMembershipController.readAllWithUserId(userDocId);

    await for (final memberships in membershipsStream) {
      final groupStreams = memberships.map((membership) {
        if (membership == null) {
          return const Stream<GroupWithId?>.empty();
        }

        return GroupController.read(membership.groupId).map((group) {
          if (group == null) {
            return null;
          }
          return GroupWithId(group: group, groupId: membership.groupId);
        });
      });

      // CombineLatestStreamを使用して、複数のストリームの最新の値を結合
      final combinedStream = CombineLatestStream.list(groupStreams)
          .map((groups) => groups.whereType<GroupWithId>().toList());

      // 結合されたストリームを購読し、変更があるたびにリストを更新
      await for (final groupsWithId in combinedStream) {
        yield groupsWithId;
      }
    }
  },
);

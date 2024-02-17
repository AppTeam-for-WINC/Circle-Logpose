import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../services/database/group_controller.dart';
import '../../../../home/parts/group/controller/joined_group_controller.dart';

final readGroupWithIdModalProvider =
    FutureProvider.family<List<GroupWithId>, List<String>>((ref, groupIdList) {
  return Future.wait<GroupWithId?>(
    groupIdList.map(
      (groupId) async {
        final groupProfile = await GroupController.readFuture(groupId);
        if (groupProfile == null) {
          return null;
        }
        return GroupWithId(
          groupProfile: groupProfile,
          groupId: groupId,
        );
      },
    ),
  ).then((data) => data.whereType<GroupWithId>().toList());
});

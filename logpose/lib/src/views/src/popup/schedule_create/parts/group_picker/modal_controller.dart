import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../models/group/group_with_id.model.dart';

import '../../../../../../services/database/crud/group_controller.dart';

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

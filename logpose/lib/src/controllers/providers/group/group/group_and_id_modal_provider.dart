import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/group_and_id_model.dart';
import '../../../../services/database/group_controller.dart';

final readGroupAndIdModalProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>((ref, groupIdList) {
  return Future.wait<GroupAndId?>(
    groupIdList.map(
      (groupId) async {
        final groupProfile = await GroupController.readFuture(groupId);
        if (groupProfile == null) {
          return null;
        }
        return GroupAndId(
          groupProfile: groupProfile,
          groupId: groupId,
        );
      },
    ),
  ).then((data) => data.whereType<GroupAndId>().toList());
});

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/group/group_and_id_model.dart';
import '../../../services/database/group_controller.dart';

/// Watch Group and Group ID.
final watchGroupAndIdProvider =
    StreamProvider.family<GroupAndId?, String>((ref, groupId) {
  return GroupController.watch(groupId).map((groupProfile) {
    if (groupProfile == null) {
      return null;
    }
    return GroupAndId(groupProfile: groupProfile, groupId: groupId);
  }).handleError((Object e) {
    debugPrint('Failed to watch Group, Group ID. $e');
    return const Stream<GroupAndId?>.empty();
  });
});


// <-以下のコードでは、UIのシンプリシティと開発の迅速性を高めることができる。->

// final watchGroupAndIdProvider =
//     StreamProvider.family<GroupAndId, String>((ref, groupId) async* {
//   final groupProfileStream = GroupController.watch(groupId);
//   await for (final groupProfile in groupProfileStream) {
//     if (groupProfile == null) {
//       continue;
//     }
//     yield GroupAndId(groupProfile: groupProfile, groupId: groupId);
//   }
// });

// <->

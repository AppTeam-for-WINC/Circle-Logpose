import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_repository.dart';

import '../../../models/custom/group_and_id_model.dart';

/// Watch Group and Group ID.
final watchGroupAndIdProvider =
    StreamProvider.family<GroupAndId?, String>((ref, groupId) {
  return GroupRepository.watch(groupId).map((groupProfile) {
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
//   final groupProfileStream = GroupRepository.watch(groupId);
//   await for (final groupProfile in groupProfileStream) {
//     if (groupProfile == null) {
//       continue;
//     }
//     yield GroupAndId(groupProfile: groupProfile, groupId: groupId);
//   }
// });

// <->

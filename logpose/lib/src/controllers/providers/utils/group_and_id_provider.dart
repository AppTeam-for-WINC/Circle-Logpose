import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/group/group_and_id_model.dart';

import '../../../services/database/group_controller.dart';

final watchGroupAndIdProvider =
    StreamProvider.family<GroupAndId, String>((ref, groupId) async* {
  final groupProfileStream = GroupController.read(groupId);
  await for (final groupProfile in groupProfileStream) {
    if (groupProfile == null) {
      continue;
    }
    yield GroupAndId(groupProfile: groupProfile, groupId: groupId);
  }
});

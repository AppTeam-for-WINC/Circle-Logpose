import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/group/group_with_id.model.dart';

import '../../../services/database/crud/group_controller.dart';

final watchGroupWithIdProvider =
    StreamProvider.family<GroupWithId, String>((ref, groupId) async* {
  final groupProfileStream = GroupController.read(groupId);
  await for (final groupProfile in groupProfileStream) {
    if (groupProfile == null) {
      continue;
    }
    yield GroupWithId(groupProfile: groupProfile, groupId: groupId);
  }
});

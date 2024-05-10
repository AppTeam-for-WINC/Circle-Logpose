import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/custom/group_and_id_model.dart';
import '../../../controllers/group/fetch/fetch_group_and_id.dart';

/// Get 'Group and ID' by 'Group ID'
final fetchGroupAndIdProvider =
    FutureProvider.family<GroupAndId, String>((ref, groupId) async {
  return FetchGroupAndId.fetchGroupAndId(groupId);
});

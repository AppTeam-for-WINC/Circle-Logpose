import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/custom/group_and_id_model.dart';
import '../../../controllers/group/fetch/group_and_id_fetcher.dart';

/// Get 'Group and ID' by 'Group ID'
final fetchGroupAndIdProvider =
    FutureProvider.family<GroupAndId, String>((ref, groupId) async {
  return GroupAndIdFetcher.fetchGroupAndId(groupId);
});

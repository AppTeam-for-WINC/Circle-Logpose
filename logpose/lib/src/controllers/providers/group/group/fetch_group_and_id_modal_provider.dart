import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/custom/group_and_id_model.dart';
import '../../../controllers/group/fetch/fetch_group_and_id.dart';

/// Get 'List of Group and ID' by 'Group ID List'
final fetchGroupAndIdModalProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>(
        (ref, groupIdList) async {
  return FetchGroupAndId.fetchGroupAndIdList(groupIdList);
});

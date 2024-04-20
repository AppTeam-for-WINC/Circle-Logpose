import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/group_and_id_model.dart';
import '../../../src/group/fetch/group_profile_fetcher.dart';

/// Get 'List of Group and ID' by 'Group ID List'
final readGroupAndIdModalProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>((ref, groupIdList) {
  final futures = GroupProfileFetcher.fromMap(groupIdList);
  return Future.wait<GroupAndId?>(futures)
      .then((data) => data.whereType<GroupAndId>().toList());
});

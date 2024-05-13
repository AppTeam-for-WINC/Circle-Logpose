import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/custom/group_and_id_model.dart';

import '../../../controllers/group/fetch/group_and_id_fetcher.dart';

final fetchGroupAndIdListProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>(
        (ref, groupIdList) async {
  return const GroupAndIdFetcher().fetchGroupAndIdList(groupIdList);
});

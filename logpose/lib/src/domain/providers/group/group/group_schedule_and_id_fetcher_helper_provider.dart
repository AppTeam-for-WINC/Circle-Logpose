import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_schedule_and_id_fetcher_helper.dart';

final groupScheduleAndIdFetcherHelperProvider =
    Provider<GroupScheduleAndIdFetcherHelper>(
  (ref) => GroupScheduleAndIdFetcherHelper(ref: ref),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/group_profile_and_schedule_and_id_model.dart';

import '../../usecase/facade/group_facade.dart';
import 'sort_option_provider.dart';

final sortedGroupAndScheduleAndIdProvider =
    StreamProvider.autoDispose<List<GroupProfileAndScheduleAndId>>(
        (ref) async* {
  final groupAndScheduleSortedStream = ref.read(groupFacadeProvider);
  final sortOption = ref.watch(sortOptionProvider);

  yield* groupAndScheduleSortedStream.sortedGroupAndScheduleStream(sortOption);
});

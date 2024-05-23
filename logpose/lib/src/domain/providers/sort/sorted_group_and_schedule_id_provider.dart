import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_facade.dart';

import '../../model/group_profile_and_schedule_and_id_model.dart';

import 'sort_option_provider.dart';

final sortedGroupAndScheduleAndIdProvider =
    StreamProvider<List<GroupProfileAndScheduleAndId>>(
        (ref) async* {
  final groupAndScheduleSortedStream = ref.watch(groupFacadeProvider);
  final sortOption = ref.watch(sortOptionProvider);

  yield* groupAndScheduleSortedStream.sortedGroupAndScheduleStream(sortOption);
});

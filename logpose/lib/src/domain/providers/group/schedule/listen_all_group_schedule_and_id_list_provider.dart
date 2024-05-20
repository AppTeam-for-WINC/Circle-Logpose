import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/group_schedule_and_id_model.dart';

import '../../../usecase/facade/group_schedule_facade.dart';

final listenAllGroupScheduleAndIdListProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    yield* groupScheduleFacade.listenAllGroupScheduleAndIdList(groupId);
  },
);

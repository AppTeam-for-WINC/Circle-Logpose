import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_profile_and_schedule_and_id_model.dart';

import '../../controllers/group/fetch/group_and_schedule_and_id_list_listener.dart';

final watchGroupAndScheduleAndIdProvider =
    StreamProvider<List<GroupProfileAndScheduleAndId>>((ref) async* {
  yield* GroupAndScheduleAndIdListListener.listenGroupAndScheduleAndIdList();
});

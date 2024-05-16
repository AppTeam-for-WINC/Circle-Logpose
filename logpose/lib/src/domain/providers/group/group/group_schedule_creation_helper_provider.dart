import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_schedule_creation_helper.dart';

final groupScheduleCreationHelperProvider =
    Provider<GroupScheduleCreationHelper>((ref) {
  return GroupScheduleCreationHelper(ref: ref);
});

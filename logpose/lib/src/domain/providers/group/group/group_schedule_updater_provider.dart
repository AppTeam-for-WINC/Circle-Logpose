import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_schedule_update_helper.dart';

final groupScheduleUpdateHelperProvider = Provider<GroupScheduleUpdateHelper>(
  (ref) => GroupScheduleUpdateHelper(ref: ref),
);

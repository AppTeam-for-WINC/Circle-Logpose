import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/update/group_schedule_updater.dart';

final groupScheduleUpdaterProvider = Provider<GroupScheduleUpdater>(
  (ref) => const GroupScheduleUpdater(),
);

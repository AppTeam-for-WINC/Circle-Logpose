import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/create/group_schedule_creator.dart';

final groupScheduleCreatorProvider = Provider<GroupScheduleCreator>(
  (ref) => const GroupScheduleCreator(),
);

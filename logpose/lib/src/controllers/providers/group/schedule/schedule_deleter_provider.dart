import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/delete/schedule_deleter.dart';

final scheduleDeleterProvider = Provider<ScheduleDeleter>(
  (ref) => const ScheduleDeleter(),
);

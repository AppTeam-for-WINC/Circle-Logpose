import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/schedule_validator.dart';

final scheduleValidatorProvider = Provider<ScheduleValidator>(
  (ref) => const ScheduleValidator(),
);

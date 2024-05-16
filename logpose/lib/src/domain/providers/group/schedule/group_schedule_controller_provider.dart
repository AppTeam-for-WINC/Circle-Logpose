import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/database/group_schedule_repository.dart';

final groupScheduleRepositoryProvider = Provider<GroupScheduleRepository>(
  (ref) => GroupScheduleRepository.instance,
);

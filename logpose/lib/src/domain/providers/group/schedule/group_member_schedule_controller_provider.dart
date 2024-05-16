import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/database/member_schedule_repository.dart';

final groupMemberScheduleRepositoryProvider =
    Provider<GroupMemberScheduleRepository>(
  (ref) => GroupMemberScheduleRepository.instance,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/member_schedule_repository.dart';
import '../../interface/i_group_member_schedule_repository.dart';

final groupMemberScheduleRepositoryProvider =
    Provider<IGroupMemberScheduleRepository>(
  (ref) => GroupMemberScheduleRepository.instance,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_member_schedule_creation_helper.dart';

final groupMemberScheduleCreationHelperProvider =
    Provider<GroupMemberScheduleCreationHelper>(
  (ref) => GroupMemberScheduleCreationHelper(ref: ref),
);

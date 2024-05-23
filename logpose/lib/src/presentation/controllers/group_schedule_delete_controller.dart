import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_schedule_facade.dart';

import '../../domain/entity/user_profile.dart';

final groupScheduleDeleteControllerProvider =
    Provider<GroupScheduleDeleteController>(
  GroupScheduleDeleteController.new,
);

class GroupScheduleDeleteController {
  GroupScheduleDeleteController(this.ref);
  final Ref ref;

  Future<void> deleteSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    await groupScheduleFacade.deleteSchedule(
      groupMemberList,
      groupScheduleId,
    );
  }
}

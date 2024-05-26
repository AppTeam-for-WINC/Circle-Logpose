import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_member_schedule_facade.dart';

import '../../../domain/entity/user_profile.dart';

final groupMemberScheduleDeletionControllerProvider =
    Provider<GroupMemberScheduleDeletionController>(
  GroupMemberScheduleDeletionController.new,
);

class GroupMemberScheduleDeletionController {
  GroupMemberScheduleDeletionController(this.ref);

  final Ref ref;

  Future<void> deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    final groupMemberScheduleFacade =
        ref.read(groupMemberScheduleFacadeProvider);
    await groupMemberScheduleFacade.deleteAllMemberSchedule(
      groupMemberList,
      groupScheduleId,
    );
  }
}

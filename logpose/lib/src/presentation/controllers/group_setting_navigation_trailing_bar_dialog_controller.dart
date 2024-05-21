import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_facade.dart';

import '../../domain/entity/user_profile.dart';

import '../../domain/model/group_id_and_schedule_id_and_member_list_model.dart';

final groupSettingNavigationTrailingBarDialogControllerProvider =
    Provider<GroupSettingNavigationTrailingBarDialogController>(
  GroupSettingNavigationTrailingBarDialogController.new,
);

class GroupSettingNavigationTrailingBarDialogController {
  const GroupSettingNavigationTrailingBarDialogController(this.ref);

  final Ref ref;

  Future<void> delete(
    String groupId,
    String? groupScheduleId,
    List<UserProfile?> groupMemberList,
  ) async {
    final groupFacade = ref.read(groupFacadeProvider);
    await groupFacade.deleteGroup(
      GroupIdAndScheduleIdAndMemberList(
        groupId: groupId,
        groupScheduleId: groupScheduleId,
        groupMemberList: groupMemberList,
      ),
    );
  }
}

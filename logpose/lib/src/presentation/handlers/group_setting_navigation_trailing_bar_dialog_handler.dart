import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';
import '../../domain/model/group_schedule_and_id_model.dart';
import '../../domain/providers/group/members/listen_group_member_profile_list.dart';
import '../../domain/providers/group/schedule/listen_all_group_schedule_and_id_list_provider.dart';
import '../controllers/group_setting_navigation_trailing_bar_dialog_controller.dart';
import '../navigations/group_setting_navigation_trailing_bar_navigator.dart';

class GroupSettingNavigationTrailingBarDialogHandler {
  GroupSettingNavigationTrailingBarDialogHandler(
    this.context,
    this.ref,
    this.groupId,
  );

  final BuildContext context;
  final WidgetRef ref;
  final String groupId;

  Future<void> handleToDelete() async {
    await _deleteSchedule(context, groupId);
    await _moveToPage();
  }

  Future<void> _deleteSchedule(BuildContext context, String groupId) async {
    ref.watch(listenGroupMemberProfileListProvider(groupId)).when(
          data: (groupMemberList) async {
            await _watchGroupScheduleAndId(groupId, groupMemberList);
          },
          loading: () => [const SizedBox.shrink()],
          error: (error, stack) => [Text('$error')],
        );
  }

  Future<void> _watchGroupScheduleAndId(
    String groupId,
    List<UserProfile?> groupMemberList,
  ) async {
    ref.watch(listenAllGroupScheduleAndIdListProvider(groupId)).when(
          data: (groupScheduleList) async {
            await _deleteGroup(
              groupScheduleList,
              groupId,
              groupMemberList,
            );
          },
          loading: () => [const SizedBox.shrink()],
          error: (error, stack) => [Text('$error')],
        );
  }

  Future<void> _deleteGroup(
    List<GroupScheduleAndId?> groupScheduleList,
    String groupId,
    List<UserProfile?> groupMemberList,
  ) async {
    try {
      await _attemptToDelete(groupScheduleList, groupId, groupMemberList);
    } on Exception catch (e) {
      debugPrint('Error: failed to delete group. $e');
    }
  }

  Future<void> _attemptToDelete(
    List<GroupScheduleAndId?> groupScheduleList,
    String groupId,
    List<UserProfile?> groupMemberList,
  ) async {
    final deleteController =
        ref.read(groupSettingNavigationTrailingBarDialogControllerProvider);
    if (groupScheduleList.isEmpty) {
      await deleteController.delete(groupId, null, groupMemberList);
    }
    await Future.wait(
      groupScheduleList.map((data) async {
        if (data == null) {
          return;
        }
        await deleteController.delete(
          groupId,
          data.groupScheduleId,
          groupMemberList,
        );
      }),
    );
  }

  Future<void> _moveToPage() async {
    if (!context.mounted) {
      return;
    }
    final navigator = GroupSettingNavigationTrailingBarNavigator(context);
    await navigator.moveToScheduleListPage();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/group_member_schedule/group_member_schedule_creation_and_update_controller.dart';
import '../navigations/pop_navigator.dart';
import '../notifiers/group_member_schedule_notifier.dart';

class EndPickerButtonHandler {
  const EndPickerButtonHandler({
    required this.context,
    required this.ref,
    required this.groupScheduleId,
    required this.memberScheduleId,
    required this.endAt,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupScheduleId;
  final String memberScheduleId;
  final DateTime? endAt;

  Future<void> setJoinTime(DateTime newTime) async {
    final memberScheduleNotifier = ref.watch(
      groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
    );
    await memberScheduleNotifier.setEndAt(newTime);
  }

  Future<void> updateJoinTime() async {
    await _updateEndAt();
    _moveToPage();
  }

  Future<void> _updateEndAt() async {
    final memberScheduleUpdater =
        ref.read(groupMemberScheduleCreationAndUpdateControllerProvider);
    await memberScheduleUpdater.updateEndAt(memberScheduleId, endAt);
  }

  void _moveToPage() {
    if (context.mounted) {
      PopNavigator(context).pop();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/member_schedule_time_updater_controller.dart';
import '../navigations/pop_navigator.dart';
import '../notifiers/group_member_schedule_notifier.dart';

class StartPickerButtonHandler {
  const StartPickerButtonHandler({
    required this.context,
    required this.ref,
    required this.groupScheduleId,
    required this.memberScheduleId,
    required this.startAt,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupScheduleId;
  final String memberScheduleId;
  final DateTime? startAt;

  Future<void> setJoinTime(DateTime newTime) async {
    final memberScheduleNotifier = ref.watch(
      groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
    );
    await memberScheduleNotifier.setStartAt(newTime);
  }

  Future<void> updateJoinTime() async {
    await _updateStartAt();
    _moveToPage();
  }

  Future<void> _updateStartAt() async {
    final memberScheduleUpdater =
        ref.read(memberScheduleUpdaterControllerProvider);
    await memberScheduleUpdater.updateStartAt(memberScheduleId, startAt);
  }

  void _moveToPage() {
    if (context.mounted) {
      PopNavigator(context).pop();
    }
  }
}

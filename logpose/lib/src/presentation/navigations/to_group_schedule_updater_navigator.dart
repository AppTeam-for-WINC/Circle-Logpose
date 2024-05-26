import 'package:flutter/cupertino.dart';

import '../components/components/popup/group_schedule_updater/group_schedule_updater.dart';

class ToGroupScheduleUpdaterNavigator {
  ToGroupScheduleUpdaterNavigator(this.context);

  final BuildContext context;

  Future<void> showModal(String groupScheduleId) async {
    await showCupertinoModalPopup<GroupScheduleUpdater>(
      context: context,
      builder: (BuildContext context) {
        return GroupScheduleUpdater(groupScheduleId: groupScheduleId);
      },
    );
  }
}

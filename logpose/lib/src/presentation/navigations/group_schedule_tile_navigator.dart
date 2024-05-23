import 'package:flutter/cupertino.dart';

import '../components/components/popup/group_schedule_updater/group_schedule_updater.dart';

class GroupScheduleTileNavigator {
  GroupScheduleTileNavigator(this.context, this.groupScheduleId);

  final BuildContext context;
  final String groupScheduleId;

  Future<void> showModal() async {
    await showCupertinoModalPopup<GroupScheduleUpdater>(
      context: context,
      builder: (BuildContext context) {
        return GroupScheduleUpdater(
          groupScheduleId: groupScheduleId,
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components/popup/group_schedule_creation/group_schedule_creation.dart';

class ScheduleAdditionSwitchModalNavigator {
  ScheduleAdditionSwitchModalNavigator(this.context, this.ref, this.groupId);

  final BuildContext context;
  final WidgetRef ref;
  final String groupId;

  Future<void> showModal() async {
    await showCupertinoModalPopup<GroupScheduleCreation>(
      context: context,
      builder: (BuildContext context) {
        return GroupScheduleCreation(groupId: groupId);
      },
    );
  }
}

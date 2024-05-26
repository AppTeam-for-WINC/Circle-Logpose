import 'package:flutter/cupertino.dart';

import '../../components/components/popup/group_schedule_creation/group_schedule_creation.dart';

class ToGroupScheduleCreationNavigator {
  ToGroupScheduleCreationNavigator(this.context);

  final BuildContext context;

  Future<void> showModal(String? groupId) async {
    await showCupertinoModalPopup<GroupScheduleCreation>(
      context: context,
      builder: (BuildContext context) {
        return GroupScheduleCreation(groupId: groupId);
      },
    );
  }
}

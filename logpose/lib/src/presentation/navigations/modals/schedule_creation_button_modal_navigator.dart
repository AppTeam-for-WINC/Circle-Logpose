import 'package:flutter/cupertino.dart';

import '../../components/components/popup/group_schedule_creation/group_schedule_creation.dart';

class ScheduleCreationButtonModalNavigator {
  ScheduleCreationButtonModalNavigator(this.context);

  final BuildContext context;

  Future<void> showModal() async {
    await showCupertinoModalPopup<GroupScheduleCreation>(
      context: context,
      builder: (BuildContext context) {
        return const GroupScheduleCreation();
      },
    );
  }
}

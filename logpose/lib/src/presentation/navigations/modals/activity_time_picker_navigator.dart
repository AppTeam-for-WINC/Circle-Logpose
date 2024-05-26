import 'package:flutter/cupertino.dart';

import '../../components/common/schedule_section/schedule_time/components/activity_end_at.dart';
import '../../components/common/schedule_section/schedule_time/components/activity_start_at.dart';

class ActivityTimePickerNavigator {
  ActivityTimePickerNavigator(this.context);

  final BuildContext context;

  Future<void> showModalStartAt(String? groupScheduleId) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return ActivityStartAtPicker(groupScheduleId: groupScheduleId);
      },
    );
  }

  Future<void> showModalEndAt(String? groupScheduleId) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return ActivityEndAtPicker(groupScheduleId: groupScheduleId);
      },
    );
  }
}

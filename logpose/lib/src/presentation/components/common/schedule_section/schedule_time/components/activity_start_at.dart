import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../notifiers/group_schedule_notifier.dart';
import '../../../activity_time_picker.dart';

class ActivityStartAtPicker extends ConsumerStatefulWidget {
  const ActivityStartAtPicker({super.key, this.groupScheduleId});
  final String? groupScheduleId;

  @override
  ConsumerState createState() => _ActivityStartAtPickerState();
}

class _ActivityStartAtPickerState extends ConsumerState<ActivityStartAtPicker> {
  @override
  Widget build(BuildContext context) {
    void onDateTimeChanged(DateTime newDateTime) {
      ref
          .watch(groupScheduleNotifierProvider(widget.groupScheduleId).notifier)
          .setStartAt(newDateTime);
    }

    return ActivityTimePicker(
      minimumDate: DateTime.now(),
      onDateTimeChanged: onDateTimeChanged,
    );
  }
}

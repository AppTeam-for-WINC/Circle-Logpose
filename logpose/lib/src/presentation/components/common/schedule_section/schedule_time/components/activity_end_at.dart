import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../notifiers/group_schedule_notifier.dart';
import '../../../activity_time_picker.dart';

class ActivityEndAtPicker extends ConsumerStatefulWidget {
  const ActivityEndAtPicker({super.key, this.groupScheduleId});
  final String? groupScheduleId;

  @override
  ConsumerState createState() => _ActivityEndAtPickerState();
}

class _ActivityEndAtPickerState extends ConsumerState<ActivityEndAtPicker> {
  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.groupScheduleId;
    final schedule = ref.watch(groupScheduleNotifierProvider(groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    void onDateTimeChanged(DateTime newDateTime) {
      ref
          .watch(groupScheduleNotifierProvider(groupScheduleId).notifier)
          .setEndAt(newDateTime);
    }

    // Delayed 10minutes with StartAt.
    return ActivityTimePicker(
      initialDateTime: schedule.startAt.add(
        const Duration(minutes: 10),
      ),
      minimumDate: schedule.startAt.add(
        const Duration(minutes: 10),
      ),
      onDateTimeChanged: onDateTimeChanged,
    );
  }
}

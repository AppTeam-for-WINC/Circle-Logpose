import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';

class ActivityEndAtPicker extends ConsumerStatefulWidget {
  const ActivityEndAtPicker({super.key, this.groupScheduleId});
  final String? groupScheduleId;

  @override
  ConsumerState createState() => _ActivityEndAtPickerState();
}

class _ActivityEndAtPickerState extends ConsumerState<ActivityEndAtPicker> {
  void _cancel() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  void _complete() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.groupScheduleId;
    final scheduleNotifier =
        ref.watch(setGroupScheduleProvider(groupScheduleId).notifier);

    final schedule = ref.watch(setGroupScheduleProvider(groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CupertinoButton(
                  onPressed: _cancel,
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  onPressed: _complete,
                  child: const Text(
                    '完了',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Delayed 10minutes with StartAt.
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: schedule.startAt.add(
                const Duration(minutes: 10),
              ),
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: schedule.startAt.add(
                const Duration(minutes: 10),
              ),
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setEndAt(newDateTime);
              },
            ),
          ),
        ],
      ),
    );
  }
}

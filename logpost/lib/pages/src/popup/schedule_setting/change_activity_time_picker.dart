import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'schedule_change_controller.dart';

class ChangeActivityStartDateTimePicker extends ConsumerStatefulWidget {
  const ChangeActivityStartDateTimePicker({
    super.key,
    required this.scheduleId,
  });

  final String scheduleId;
  @override
  ConsumerState createState() => _ChangeActivityStartDateTimePickerState();
}

class _ChangeActivityStartDateTimePickerState
    extends ConsumerState<ChangeActivityStartDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final scheduleId = widget.scheduleId;
    final scheduleNotifier =
        ref.watch(changeGroupScheduleProvider(scheduleId).notifier);
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
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  child: const Text(
                    '完了',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (!mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              // initialDateTime: schedule!.startAt,
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: DateTime.now(),
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setStartAt(newDateTime);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeActivityEndDateTimePicker extends ConsumerStatefulWidget {
  const ChangeActivityEndDateTimePicker({super.key, required this.scheduleId});

  final String scheduleId;
  @override
  ConsumerState createState() => _ChangeActivityEndDateTimePickerState();
}

class _ChangeActivityEndDateTimePickerState
    extends ConsumerState<ChangeActivityEndDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final scheduleId = widget.scheduleId;
    final schedule = ref.watch(changeGroupScheduleProvider(scheduleId));
    final scheduleNotifier =
        ref.watch(changeGroupScheduleProvider(scheduleId).notifier);
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
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  child: const Text(
                    '完了',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (!mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          // Delayed 10minutes with StartAt.
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: schedule!.startAt.add(
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

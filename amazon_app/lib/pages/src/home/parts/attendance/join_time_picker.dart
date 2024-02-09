import 'package:amazon_app/pages/src/popup/schedule_create/schedule_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinScheduleStartDateTimePicker extends ConsumerStatefulWidget {
  const JoinScheduleStartDateTimePicker({super.key});
  @override
  ConsumerState createState() => _JoinScheduleStartDateTimePickerState();
}

class _JoinScheduleStartDateTimePickerState
    extends ConsumerState<JoinScheduleStartDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);
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

class JoinScheduleEndDateTimePicker extends ConsumerStatefulWidget {
  const JoinScheduleEndDateTimePicker({super.key});
  @override
  ConsumerState createState() => _JoinScheduleEndDateTimePickerState();
}

class _JoinScheduleEndDateTimePickerState
    extends ConsumerState<JoinScheduleEndDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(createGroupScheduleProvider);
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);
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

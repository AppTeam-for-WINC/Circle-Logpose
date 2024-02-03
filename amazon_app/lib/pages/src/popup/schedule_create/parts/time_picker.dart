import 'package:amazon_app/controller/common/time_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/schedule_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityStartDateTimePicker extends ConsumerStatefulWidget {
  const ActivityStartDateTimePicker({super.key});
  @override
  ConsumerState createState() => _ActivityStartDateTimePickerState();
}

class _ActivityStartDateTimePickerState
    extends ConsumerState<ActivityStartDateTimePicker> {
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
                    scheduleNotifier.setSchedule(
                      null,
                      scheduleNotifier.schedule!.startAt,
                      null,
                    );
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
              initialDateTime: scheduleNotifier.startInitAt,
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: scheduleNotifier.startInitAt,
              // minuteInterval: 5,
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setSchedule(null, newDateTime, null);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityEndDateTimePicker extends ConsumerWidget {
  const ActivityEndDateTimePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      // initialDateTime: scheduleNotifier.endAt,
      onDateTimeChanged: (newDateTime) {},
    );
  }
}

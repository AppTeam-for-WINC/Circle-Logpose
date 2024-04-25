import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';

class ActivityStartAtPicker extends ConsumerStatefulWidget {
  const ActivityStartAtPicker({super.key});
  @override
  ConsumerState createState() => _ActivityStartAtPickerState();
}

class _ActivityStartAtPickerState
    extends ConsumerState<ActivityStartAtPicker> {
  @override
  Widget build(BuildContext context) {
    final scheduleNotifier = ref.watch(setGroupScheduleProvider(null).notifier);
    
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

import 'package:amazon_app/controller/common/time_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/schedule_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleActivityTime extends ConsumerStatefulWidget {
  const ScheduleActivityTime({super.key});

  @override
  ConsumerState createState() => _ScheduleActivityTimeState();
}

class _ScheduleActivityTimeState extends ConsumerState<ScheduleActivityTime> {
  @override
  Widget build(BuildContext context) {
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);
    return Container(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: const Icon(
              Icons.schedule,
              size: 25,
              color: Colors.grey,
            ),
          ),
          CupertinoButton(
            onPressed: () {

            },
            padding: EdgeInsets.zero,
            child: Text(
              formatDateTimeExcYear(
                formatString(scheduleNotifier.startAt),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 2,
            ),
            child: Text(
              '~',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          CupertinoButton(
            onPressed: () {

            },
            padding: EdgeInsets.zero,
            child: Text(
              formatDateTimeExcYear(
                formatString(scheduleNotifier.endAt),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

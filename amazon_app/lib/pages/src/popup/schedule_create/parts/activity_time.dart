import 'package:amazon_app/controller/common/time_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/parts/time_picker.dart';
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
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return const ActivityStartDateTimePicker();
                },
              );
            },
            padding: EdgeInsets.zero,
            child: Consumer(
              builder: (context, watch, child) {
                final scheduleStartAt = ref.watch(setGroupScheduleStartAtProvider);
                final result = formatDateTimeExcYear(scheduleStartAt);
                return Text(result);
              },
            ),
            // child: Text(
            //   formatDateTimeExcYear(
            //     scheduleStartAt.state,
            //     // scheduleNotifier.startAt,
            //   ),
            //   style: const TextStyle(
            //     color: Colors.black,
            //   ),
            // ),
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
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return const ActivityEndDateTimePicker();
                },
              );
            },
            padding: EdgeInsets.zero,
            child: Consumer(
              builder: (context, watch, child) {
                final scheduleEndAt = ref.watch(setGroupScheduleEndAtProvider);
                final result = formatDateTimeExcYear(scheduleEndAt);
                return Text(result);
              },
            ),
            // child: Text(
            //   formatDateTimeExcYear(
            //     scheduleNotifier.endAt,
            //     // scheduleNotifier.schedule!.endAt,
            //   ),
            //   style: const TextStyle(
            //     color: Colors.black,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

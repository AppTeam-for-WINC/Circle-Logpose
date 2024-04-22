import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/schedule/group_schedule_provider.dart';
import '../../../../../utils/time/time_utils.dart';

import 'time_picker/activity_end_at.dart';
import 'time_picker/activity_start_at.dart';

class ScheduleActivityTime extends ConsumerStatefulWidget {
  const ScheduleActivityTime({super.key});
  @override
  ConsumerState createState() => _ScheduleActivityTimeState();
}

class _ScheduleActivityTimeState extends ConsumerState<ScheduleActivityTime> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(setGroupScheduleProvider(null));
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
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
                return const ActivityStartAtPicker();
              },
            );
          },
          padding: EdgeInsets.zero,
          child: Consumer(
            builder: (context, watch, child) {
              return Text(formatDateTimeExcYear(schedule!.startAt));
            },
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
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) {
                return const ActivityEndAtPicker();
              },
            );
          },
          padding: EdgeInsets.zero,
          child: Consumer(
            builder: (context, watch, child) {
                return Text(formatDateTimeExcYear(schedule!.endAt));
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/schedule/group_schedule_provider.dart';
import '../../../../utils/time/time_utils.dart';

import 'update_activity_end_time.dart';
import 'update_activity_start_time_picker.dart';

class UpdateScheduleActivityTime extends ConsumerStatefulWidget {
  const UpdateScheduleActivityTime({super.key, required this.scheduleId});

  final String scheduleId;
  @override
  ConsumerState createState() => _UpdateScheduleActivityTimeState();
}

class _UpdateScheduleActivityTimeState
    extends ConsumerState<UpdateScheduleActivityTime> {
  @override
  Widget build(BuildContext context) {
    final scheduleId = widget.scheduleId;

    final schedule = ref.watch(setGroupScheduleProvider(scheduleId));

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
                return UpdateActivityStartAtPicker(
                  scheduleId: scheduleId,
                );
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
                return UpdateActivityEndAtPicker(scheduleId: scheduleId);
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

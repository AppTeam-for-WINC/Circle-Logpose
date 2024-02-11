import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/common/time_controller.dart';
import 'change_activity_time_picker.dart';
import 'schedule_change_controller.dart';

class ChangeScheduleActivityTime extends ConsumerStatefulWidget {
  const ChangeScheduleActivityTime({super.key, required this.scheduleId});

  final String scheduleId;
  @override
  ConsumerState createState() => _ChangeScheduleActivityTimeState();
}

class _ChangeScheduleActivityTimeState
    extends ConsumerState<ChangeScheduleActivityTime> {
  @override
  Widget build(BuildContext context) {
    final scheduleId = widget.scheduleId;
    final schedule = ref.watch(changeGroupScheduleProvider(scheduleId));
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
                return ChangeActivityStartDateTimePicker(
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
                return ChangeActivityEndDateTimePicker(scheduleId: scheduleId);
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

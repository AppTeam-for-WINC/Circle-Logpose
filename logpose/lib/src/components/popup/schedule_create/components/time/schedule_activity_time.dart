import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';
import '../../../../../utils/time/time_utils.dart';

import 'components/activity_end_at.dart';
import 'components/activity_start_at.dart';

class ScheduleActivityTime extends ConsumerStatefulWidget {
  const ScheduleActivityTime({super.key});
  @override
  ConsumerState createState() => _ScheduleActivityTimeState();
}

class _ScheduleActivityTimeState extends ConsumerState<ScheduleActivityTime> {
  void _startAtPopup() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return const ActivityStartAtPicker();
      },
    );
  }

  void _endAtPopup() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return const ActivityEndAtPicker();
      },
    );
  }

  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  } 

  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(setGroupScheduleProvider(null));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

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
          onPressed: _startAtPopup,
          padding: EdgeInsets.zero,
          child: Consumer(
            builder: (context, watch, child) {
              return Text(_formatDateTimeExcYear(schedule.startAt));
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
          onPressed: _endAtPopup,
          padding: EdgeInsets.zero,
          child: Consumer(
            builder: (context, watch, child) {
              return Text(_formatDateTimeExcYear(schedule.endAt));
            },
          ),
        ),
      ],
    );
  }
}
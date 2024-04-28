import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/group/group_schedule.dart';
import '../../../utils/time/time_utils.dart';

class ScheduleActivityTime extends ConsumerWidget {
  const ScheduleActivityTime({super.key, required this.groupSchedule});
  final GroupSchedule groupSchedule;

  String _formatDateTimeExcYearHourMinuteDay(DateTime datetime) {
    return formatDateTimeExcYearHourMinuteDay(datetime);
  }

  String _formatDateTimeExcYearMonthDay(DateTime datetime) {
    return formatDateTimeExcYearMonthDay(datetime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            _formatDateTimeExcYearHourMinuteDay(groupSchedule.startAt),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.startAt),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const Text(
          '-',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.endAt),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

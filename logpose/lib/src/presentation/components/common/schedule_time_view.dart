import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/group_schedule.dart';
import '../../../utils/time_utils.dart';

class ScheduleTimeView extends StatelessWidget {
  const ScheduleTimeView({super.key, required this.groupSchedule});

  final GroupSchedule groupSchedule;

  String _formatDateTimeExcYearHourMinute(DateTime datetime) {
    return formatDateTimeExcYearHourMinute(datetime);
  }

  String _formatDateTimeExcYearMonthDay(DateTime datetime) {
    return formatDateTimeExcYearMonthDay(datetime);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            _formatDateTimeExcYearHourMinute(groupSchedule.startAt),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.startAt),
          style: const TextStyle(fontSize: 18),
        ),
        const Text('-', style: TextStyle(fontSize: 18)),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.endAt),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

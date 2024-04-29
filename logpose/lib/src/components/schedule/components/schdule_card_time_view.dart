import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/group/group_schedule.dart';
import '../../../utils/time/time_utils.dart';

class ScheduleCardTimeView extends ConsumerWidget {
  const ScheduleCardTimeView({super.key, required this.groupSchedule});
  final GroupSchedule groupSchedule;

  String _formatDateTimeExcYearMonthDay(DateTime datetime) {
    return formatDateTimeExcYearMonthDay(datetime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.startAt),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const Text(
          '-',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.endAt),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}

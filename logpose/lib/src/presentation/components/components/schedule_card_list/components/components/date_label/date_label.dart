import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/group_schedule.dart';
import '../../../../../../../utils/color/color_exchanger.dart';
import '../../../../../../../utils/time/time_utils.dart';

class DateLabel extends ConsumerWidget {
  const DateLabel({super.key, required this.groupSchedule});
  final GroupSchedule groupSchedule;

  Color _hexToColor(String color) {
    return hexToColor(color);
  }

  String _formatDateTimeExcYearHourMinute(DateTime datetime) {
    return formatDateTimeExcYearHourMinute(datetime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 80,
      height: 38,
      decoration: BoxDecoration(
        color: _hexToColor(groupSchedule.color),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Center(
        child: Text(
          _formatDateTimeExcYearHourMinute(groupSchedule.startAt),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

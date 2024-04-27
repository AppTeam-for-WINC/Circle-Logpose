import 'package:flutter/cupertino.dart';

import '../../../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import '../../../../../utils/time/time_utils.dart';

class ActivityTime extends StatelessWidget {
  const ActivityTime({
    super.key,
    required this.title,
    required this.startAt,
    required this.endAt,
    required this.groupData,
  });

  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final GroupProfileAndScheduleAndId groupData;

  String _formatDateTimeExcYearHourMinuteDay(DateTime datetime) {
    return formatDateTimeExcYearMonthDay(datetime);
  }

  String _formatDateTimeExcYearMonthDay(DateTime datetime) {
    return formatDateTimeExcYearMonthDay(datetime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            width: 220,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    _formatDateTimeExcYearHourMinuteDay(startAt),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  _formatDateTimeExcYearMonthDay(startAt),
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
                  _formatDateTimeExcYearMonthDay(endAt),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

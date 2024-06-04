import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/group_schedule.dart';
import '../../../utils/responsive_util.dart';
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
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth);
        } else {
          return _buildDesktopLayout(deviceWidth);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.032);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.022);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.018);
  }

  Widget _buildLayout(double textSize) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            _formatDateTimeExcYearHourMinute(groupSchedule.startAt),
            style: TextStyle(fontSize: textSize),
          ),
        ),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.startAt),
          style: TextStyle(fontSize: textSize),
        ),
        Text('-', style: TextStyle(fontSize: textSize)),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.endAt),
          style: TextStyle(fontSize: textSize),
        ),
      ],
    );
  }
}

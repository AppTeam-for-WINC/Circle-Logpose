import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/responsive_util.dart';
import '../../../../../../../../../utils/time_utils.dart';

import '../../../../../../../../domain/entity/group_schedule.dart';

class ScheduleCardTimeView extends ConsumerWidget {
  const ScheduleCardTimeView({super.key, required this.groupSchedule});

  final GroupSchedule groupSchedule;

  String _formatDateTimeExcYearMonthDay(DateTime datetime) {
    return formatDateTimeExcYearMonthDay(datetime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return _buildLayout(deviceWidth * 0.044);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.026);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.024);
  }

  Widget _buildLayout(double timeTextSize) {
    return Row(
      children: [
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.startAt),
          style: TextStyle(fontSize: timeTextSize),
        ),
        Text('-', style: TextStyle(fontSize: timeTextSize)),
        Text(
          _formatDateTimeExcYearMonthDay(groupSchedule.endAt),
          style: TextStyle(fontSize: timeTextSize),
        ),
      ],
    );
  }
}

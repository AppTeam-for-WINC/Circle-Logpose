import 'package:flutter/cupertino.dart';

import '../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../utils/color_exchanger.dart';
import '../../../../../../utils/responsive_util.dart';
import '../../../../../../utils/time_utils.dart';

class DateLabel extends StatelessWidget {
  const DateLabel({
    super.key,
    required this.groupSchedule,
    required this.deviceWidth,
  });

  final GroupSchedule groupSchedule;
  final double deviceWidth;

  Color _hexToColor(String color) {
    return hexToColor(color);
  }

  String _formatDateTimeExcYearHourMinute(DateTime datetime) {
    return formatDateTimeExcYearHourMinute(datetime);
  }

  @override
  Widget build(BuildContext context) {
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
    return _buildLayout(
      containerWidth: deviceWidth * 0.2,
      containerHeight: deviceWidth * 0.1,
      dateTextSize: deviceWidth * 0.048,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.16,
      containerHeight: deviceWidth * 0.06,
      dateTextSize: deviceWidth * 0.028,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.1,
      containerHeight: deviceWidth * 0.04,
      dateTextSize: deviceWidth * 0.024,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double dateTextSize,
  }) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: _hexToColor(groupSchedule.color),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Center(
        child: Text(
          _formatDateTimeExcYearHourMinute(groupSchedule.startAt),
          style: TextStyle(fontSize: dateTextSize, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

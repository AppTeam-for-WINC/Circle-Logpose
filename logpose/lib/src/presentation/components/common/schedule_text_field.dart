import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';

import 'schedule_section/schedule_field/detail_text_field.dart';
import 'schedule_section/schedule_field/place_text_field.dart';

enum ScheduleTextFieldType { place, detail }

class ScheduleTextField extends StatelessWidget {
  const ScheduleTextField({
    super.key,
    required this.icon,
    required this.scheduleTextFieldType,
  });

  final IconData icon;
  final ScheduleTextFieldType scheduleTextFieldType;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth, deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth, deviceHeight);
        } else {
          return _buildDesktopLayout(deviceWidth, deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.01,
      iconSize: deviceWidth * 0.04,
      containerSize: deviceWidth * 0.6,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.02,
      iconSize: deviceWidth * 0.035,
      containerSize: deviceWidth * 0.6,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.035,
      iconSize: deviceWidth * 0.03,
      containerSize: deviceWidth * 0.6,
    );
  }

  Widget _buildLayout({
    required double paddingTop,
    required double iconSize,
    required double containerSize,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          Icon(icon, size: iconSize, color: CupertinoColors.systemGrey),
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: containerSize,
            child: scheduleTextFieldType == ScheduleTextFieldType.place
                ? const PlaceTextField()
                : const DetailTextField(),
          ),
        ],
      ),
    );
  }
}

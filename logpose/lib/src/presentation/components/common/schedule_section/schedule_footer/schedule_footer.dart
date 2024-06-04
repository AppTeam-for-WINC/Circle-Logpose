import 'package:flutter/cupertino.dart';

import '../../../../../../utils/responsive_util.dart';

import 'schedule_save_button.dart';

class ScheduleFooter extends StatelessWidget {
  const ScheduleFooter({
    super.key,
    this.defaultGroupId,
    required this.actionType,
    this.groupScheduleId,
  });

  final String? defaultGroupId;
  final ActionType actionType;
  final String? groupScheduleId;

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
      containerWidth: deviceWidth * 0.25,
      containerHeight: deviceHeight * 0.06,
      textSize: deviceWidth * 0.038,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.2,
      containerHeight: deviceWidth * 0.08,
      textSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.18,
      containerHeight: deviceWidth * 0.06,
      textSize: deviceWidth * 0.018,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double textSize,
  }) {
    return Center(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          color: const Color(0xFF7B61FF),
        ),
        child: ScheduleSettingSaveButton(
          defaultGroupId: defaultGroupId,
          actionType: actionType,
          groupScheduleId: groupScheduleId,
          textSize: textSize,
        ),
      ),
    );
  }
}

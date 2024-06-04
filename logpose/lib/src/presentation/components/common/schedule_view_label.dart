import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';

class ScheduleViewLabel extends StatelessWidget {
  const ScheduleViewLabel({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

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
      iconSize: deviceWidth * 0.032,
      textSize: deviceWidth * 0.03,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.022,
      textSize: deviceWidth * 0.02,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.018,
      textSize: deviceWidth * 0.015,
    );
  }

  Widget _buildLayout({
    required double iconSize,
    required double textSize,
  }) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: CupertinoColors.systemGrey),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            label,
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: textSize,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';

import '../../../../../../../../utils/responsive_util.dart';

class ParticipantListLabel extends StatelessWidget {
  const ParticipantListLabel({super.key});

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
      marginTop: deviceHeight * 0.04,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.022,
      textSize: deviceWidth * 0.02,
      marginTop: deviceHeight * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.018,
      textSize: deviceWidth * 0.015,
      marginTop: deviceHeight * 0.04,
    );
  }

  Widget _buildLayout({
    required double iconSize,
    required double textSize,
    required double marginTop,
  }) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        children: [
          Icon(CupertinoIcons.group, size: iconSize),
          const SizedBox(width: 15),
          Text(
            '参加メンバー',
            style: TextStyle(
              color: CupertinoColors.black,
              fontSize: textSize,
            ),
          ),
        ],
      ),
    );
  }
}

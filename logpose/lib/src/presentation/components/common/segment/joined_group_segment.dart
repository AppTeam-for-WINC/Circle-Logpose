import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';

import '../../components/slide/src/segment_tab.dart';

class JoinedGroupSegment {
  const JoinedGroupSegment();

  SegmentTab buildRightSegment(double deviceWidth) {
    return SegmentTab(
      name: '団体',
      selectedTextColor: CupertinoColors.white,
      textColor: CupertinoColors.black,
      color: const Color(0xFF7B61FF),
      label: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveUtil.isMobile(context)) {
            return _buildMobileLayout(deviceWidth);
          } else if (ResponsiveUtil.isTablet(context)) {
            return _buildTabletLayout(deviceWidth);
          } else {
            return _buildDesktopLayout(deviceWidth);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: 15,
      groupIconSize: deviceWidth * 0.05,
      groupTextSize: deviceWidth * 0.042,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: 40,
      groupIconSize: deviceWidth * 0.032,
      groupTextSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: 40,
      groupIconSize: deviceWidth * 0.032,
      groupTextSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double sizedBoxSize,
    required double groupIconSize,
    required double groupTextSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.group,
          size: groupIconSize,
          color: CupertinoColors.white,
        ),
        SizedBox(width: sizedBoxSize),
        Text(
          '団体',
          style: TextStyle(
            fontSize: groupTextSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

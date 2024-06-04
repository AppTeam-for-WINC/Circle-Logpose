import 'package:flutter/cupertino.dart';

import '../../../../../../../../../utils/responsive_util.dart';
import '../../../../src/segment_tab.dart';

class GroupCreationSegment {
  const GroupCreationSegment();

  SegmentTab buildLeftSegment(double deviceWidth) {
    return SegmentTab(
      name: '団体作成',
      textColor: const Color.fromRGBO(0, 0, 0, 1),
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
      sizedBoxSize: 5,
      groupTextSize: deviceWidth * 0.042,
      chevronSize: deviceWidth * 0.05,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: 20,
      groupTextSize: deviceWidth * 0.025,
      chevronSize: deviceWidth * 0.032,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: 25,
      groupTextSize: deviceWidth * 0.02,
      chevronSize: deviceWidth * 0.032,
    );
  }

  Widget _buildLayout({
    required double sizedBoxSize,
    required double groupTextSize,
    required double chevronSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '団体作成',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: groupTextSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Icon(
          CupertinoIcons.chevron_down,
          size: chevronSize,
          color: CupertinoColors.white,
        ),
        SizedBox(width: sizedBoxSize),
      ],
    );
  }
}

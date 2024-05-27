import 'package:flutter/cupertino.dart';

import '../../../../../../../../utils/responsive_util.dart';

import '../../../../src/segment_tab.dart';

class ScheduleListSegment {
  const ScheduleListSegment();

  SegmentTab buildLeftSegment(double deviceWidth) {
    return SegmentTab(
      name: '出席簿',
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
      sizedBoxSize: deviceWidth * 0.06,
      allTextSize: deviceWidth * 0.03,
      attendanceTextSize: deviceWidth * 0.042,
      chevronSize: deviceWidth * 0.05,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: deviceWidth * 0.03,
      allTextSize: deviceWidth * 0.02,
      attendanceTextSize: deviceWidth * 0.025,
      chevronSize: deviceWidth * 0.035,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxSize: deviceWidth * 0.025,
      allTextSize: deviceWidth * 0.015,
      attendanceTextSize: deviceWidth * 0.02,
      chevronSize: deviceWidth * 0.025,
    );
  }

  Widget _buildLayout({
    required double sizedBoxSize,
    required double allTextSize,
    required double attendanceTextSize,
    required double chevronSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: sizedBoxSize,
          height: sizedBoxSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.20),
              borderRadius: BorderRadius.circular(33),
            ),
            child: Center(
              child: Text(
                'all',
                style: TextStyle(
                  fontSize: allTextSize,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromRGBO(255, 255, 255, 0.80),
                ),
              ),
            ),
          ),
        ),
        Text(
          '出席簿',
          style: TextStyle(
            fontSize: attendanceTextSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          CupertinoIcons.chevron_down,
          size: chevronSize,
          color: CupertinoColors.white,
        ),
      ],
    );
  }
}

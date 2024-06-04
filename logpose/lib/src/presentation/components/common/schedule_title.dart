import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';

import 'custom_text.dart';

class ScheduleTitleView extends StatelessWidget {
  const ScheduleTitleView({super.key, required this.title});

  final String title;

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
      titleWidth: deviceWidth * 0.45,
      titleMarginTop: deviceHeight * 0.12,
      titleTextSize: deviceWidth * 0.05,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      titleWidth: deviceWidth * 0.5,
      titleMarginTop: deviceHeight * 0.1,
      titleTextSize: deviceWidth * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      titleWidth: deviceWidth * 0.5,
      titleMarginTop: deviceHeight * 0.08,
      titleTextSize: deviceWidth * 0.03,
    );
  }

  Widget _buildLayout({
    required double titleWidth,
    required double titleMarginTop,
    required double titleTextSize,
  }) {
    return Container(
      margin: EdgeInsets.only(top: titleMarginTop),
      width: titleWidth,
      child: CustomText(
        text: title,
        textColor: CupertinoColors.black,
        fontSize: titleTextSize,
      ),
    );
  }
}

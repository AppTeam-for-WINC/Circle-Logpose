import 'package:flutter/cupertino.dart';

import '../../../utils/responsive_util.dart';

class SlideTab extends StatelessWidget {
  const SlideTab({
    super.key,
    required this.label,
    required this.decorationColor,
    required this.textColor,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Color decorationColor;
  final Color textColor;
  final IconData icon;
  final Future<void> Function() onTap;

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
      tabWidth: deviceWidth * 0.42,
      tabHeight: deviceHeight * 0.063,
      sizedBox: deviceWidth * 0.3,
      decorationSize: deviceWidth * 0.05,
      iconSize: deviceWidth * 0.05,
      labelTextSize: deviceWidth * 0.042,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      tabWidth: deviceWidth * 0.435,
      tabHeight: deviceHeight * 0.063,
      sizedBox: deviceWidth * 0.2,
      decorationSize: deviceWidth * 0.032,
      iconSize: deviceWidth * 0.025,
      labelTextSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      tabWidth: deviceWidth * 0.435,
      tabHeight: deviceHeight * 0.063,
      sizedBox: deviceWidth * 0.2,
      decorationSize: deviceWidth * 0.032,
      iconSize: deviceWidth * 0.02,
      labelTextSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double tabWidth,
    required double tabHeight,
    required double sizedBox,
    required double decorationSize,
    required double iconSize,
    required double labelTextSize,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: tabWidth,
        height: tabHeight,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: decorationSize,
              height: decorationSize,
              decoration: BoxDecoration(
                color: decorationColor,
                borderRadius: BorderRadius.circular(33),
              ),
              child: Center(child: Icon(icon, size: iconSize)),
            ),
            SizedBox(
              width: sizedBox,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: labelTextSize,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

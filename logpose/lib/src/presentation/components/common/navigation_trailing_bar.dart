import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';

class NavigationTrailingBar extends StatelessWidget {
  const NavigationTrailingBar({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.onPressed,
  });

  final Color iconColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoButton(
      onPressed: onPressed,
      child: LayoutBuilder(
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
    return _buildLayout(iconSize: deviceWidth * 0.06);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(iconSize: deviceWidth * 0.035);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(iconSize: deviceWidth * 0.02);
  }

  Widget _buildLayout({required double iconSize}) {
    return Icon(icon, size: iconSize, color: iconColor);
  }
}

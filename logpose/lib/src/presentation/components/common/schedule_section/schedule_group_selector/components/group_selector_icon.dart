import 'package:flutter/cupertino.dart';

import '../../../../../../../utils/responsive_util.dart';

class GroupSelectorIcon extends StatelessWidget {
  const GroupSelectorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth);
        } else {
          return _buildDesktopLayout(deviceWidth);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.04);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.035);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.03);
  }

  Widget _buildLayout(double iconSize) {
    return Icon(
      CupertinoIcons.group,
      color: CupertinoColors.systemGrey,
      size: iconSize,
    );
  }
}

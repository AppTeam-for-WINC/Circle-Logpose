import 'package:flutter/cupertino.dart';

import '../../../utils/responsive_util.dart';
import '../../navigations/pop_navigator.dart';

class BackToPageButton extends StatelessWidget {
  const BackToPageButton({super.key, required this.iconColor, this.onPressed});

  final Color iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    void handleToTap() {
      PopNavigator(context).pop();
    }

    return CupertinoButton(
      onPressed: onPressed ?? handleToTap,
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
    return _buildLayout(backIconSize: deviceWidth * 0.06);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(backIconSize: deviceWidth * 0.035);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(backIconSize: deviceWidth * 0.02);
  }

  Widget _buildLayout({required double backIconSize}) {
    return Icon(CupertinoIcons.back, size: backIconSize, color: iconColor);
  }
}

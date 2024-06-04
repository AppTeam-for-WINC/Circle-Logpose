import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';

class UserSectionLabel extends ConsumerWidget {
  const UserSectionLabel({
    super.key,
    required this.leftIcon,
    required this.text,
  });

  final IconData leftIcon;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      infoIconSize: deviceWidth * 0.06,
      forwardIconSize: deviceWidth * 0.06,
      textSize: deviceWidth * 0.04,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      infoIconSize: deviceWidth * 0.04,
      forwardIconSize: deviceWidth * 0.04,
      textSize: deviceWidth * 0.03,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      infoIconSize: deviceWidth * 0.03,
      forwardIconSize: deviceWidth * 0.03,
      textSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double infoIconSize,
    required double forwardIconSize,
    required double textSize,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Icon(
                leftIcon,
                color: CupertinoColors.black,
                size: infoIconSize,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: textSize,
                  ),
                ),
              ),
            ],
          ),
          Icon(
            CupertinoIcons.forward,
            color: CupertinoColors.black,
            size: forwardIconSize,
          ),
        ],
      ),
    );
  }
}

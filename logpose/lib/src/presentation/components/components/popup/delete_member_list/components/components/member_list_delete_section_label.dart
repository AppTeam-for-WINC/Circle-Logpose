import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';

class MemberListDeleteSectionLabel extends ConsumerWidget {
  const MemberListDeleteSectionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return _buildLayout(
      iconSize: deviceWidth * 0.06,
      textSize: deviceWidth * 0.035,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      iconSize: deviceWidth * 0.035,
      textSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      iconSize: deviceWidth * 0.03,
      textSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double iconSize,
    required double textSize,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.group, size: iconSize),
          const SizedBox(width: 10),
          Text(
            'メンバーを削除',
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

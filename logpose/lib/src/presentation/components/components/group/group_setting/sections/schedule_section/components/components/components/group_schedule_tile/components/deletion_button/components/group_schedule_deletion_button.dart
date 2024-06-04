import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../../../../../../utils/responsive_util.dart';

class GroupScheduleDeletionButtonIcon extends ConsumerWidget {
  const GroupScheduleDeletionButtonIcon({super.key});

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
    return _buildLayout(deviceWidth * 0.06);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.04);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.035);
  }

  Widget _buildLayout(double deletionIconSize) {
    return Icon(
      CupertinoIcons.delete,
      color: CupertinoColors.black,
      size: deletionIconSize,
    );
  }
}

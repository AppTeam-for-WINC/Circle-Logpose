import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../common/custom_image/custom_cached_network_image.dart';

import 'components/group_name_view.dart';

class UserJoinedGroupTileView extends ConsumerWidget {
  const UserJoinedGroupTileView({
    super.key,
    required this.groupImage,
    required this.groupName,
  });

  final String groupImage;
  final String groupName;

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
      groupImageSize: deviceWidth * 0.06,
      groupNameTextSize: deviceWidth * 0.03,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      groupImageSize: deviceWidth * 0.05,
      groupNameTextSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      groupImageSize: deviceWidth * 0.04,
      groupNameTextSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double groupImageSize,
    required double groupNameTextSize,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 219, 251),
        borderRadius: BorderRadius.circular(80),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: CustomCachedNetworkImage(
                imagePath: groupImage,
                width: groupImageSize,
                height: groupImageSize,
              ),
            ),
            GroupNameView(
              name: groupName,
              groupNameTextSize: groupNameTextSize,
            ),
          ],
        ),
      ),
    );
  }
}

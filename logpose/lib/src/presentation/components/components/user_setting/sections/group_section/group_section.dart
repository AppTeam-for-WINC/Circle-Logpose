import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';
import 'components/group_section_joined_group_tile_label.dart';
import 'components/group_section_joined_group_tile_list.dart';

class GroupSection extends ConsumerStatefulWidget {
  const GroupSection({super.key});
  @override
  ConsumerState createState() => _GroupSectionState();
}

class _GroupSectionState extends ConsumerState<GroupSection> {
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
      containerWidth: deviceWidth * 0.88,
      containerHeight: deviceHeight * 0.26,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.88,
      containerHeight: deviceHeight * 0.36,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.88,
      containerHeight: deviceHeight * 0.46,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
  }) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      margin: const EdgeInsets.only(top: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CupertinoColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroupSectionJoinedGroupTileLabel(),
            GroupSectionJoinedGroupTileList(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';

import '../../../../../../notifiers/group_section_notifier.dart';

class GroupSectionJoinedGroupTileList extends ConsumerStatefulWidget {
  const GroupSectionJoinedGroupTileList({super.key});

  @override
  ConsumerState<GroupSectionJoinedGroupTileList> createState() =>
      _GroupSectionJoinedGroupTileListState();
}

class _GroupSectionJoinedGroupTileListState
    extends ConsumerState<GroupSectionJoinedGroupTileList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

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
      containerWidth: deviceWidth * 0.86,
      containerHeight: deviceHeight * 0.22,
      childAspectRatio: 6.5,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.86,
      containerHeight: deviceHeight * 0.32,
      childAspectRatio: 10,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.86,
      containerHeight: deviceHeight * 0.42,
      childAspectRatio: 10,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double childAspectRatio,
  }) {
    final joinedGroupList = ref.watch(joinedGroupListNotifierProvider);

    return SingleChildScrollView(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: const EdgeInsets.all(5),
        child: GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          childAspectRatio: childAspectRatio,
          children: joinedGroupList,
        ),
      ),
    );
  }
}

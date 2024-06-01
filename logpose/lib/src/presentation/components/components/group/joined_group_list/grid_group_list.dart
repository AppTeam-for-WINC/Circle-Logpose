import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/responsive_util.dart';

import '../../../../notifiers/group_profile_list_notifier.dart';

class GridGroupList extends ConsumerStatefulWidget {
  const GridGroupList({super.key});

  @override
  ConsumerState<GridGroupList> createState() => _GridGroupListState();
}

class _GridGroupListState extends ConsumerState<GridGroupList> {
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
      deviceWidth: deviceWidth,
      deviceHeight: deviceHeight,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1,
      crossAxisCount: 2,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      deviceHeight: deviceHeight,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 6,
      crossAxisCount: 1,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      deviceHeight: deviceHeight,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 8,
      crossAxisCount: 1,
    );
  }

  Widget _buildLayout({
    required double deviceWidth,
    required double deviceHeight,
    required double crossAxisSpacing,
    required double mainAxisSpacing,
    required double childAspectRatio,
    required int crossAxisCount,
  }) {
    final groupList = ref.watch(groupProfileListNotifierProvider);

    return SizedBox(
      width: deviceWidth,
      height: deviceHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
              crossAxisCount: crossAxisCount,
              children: groupList,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                if (ResponsiveUtil.isMobile(context)) {
                  return const SizedBox(height: 200);
                } else if (ResponsiveUtil.isTablet(context)) {
                  return const SizedBox(height: 400);
                } else {
                  return const SizedBox(height: 600);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

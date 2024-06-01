import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../../../notifiers/group_schedule_tile_list_builder_notifier.dart';

class GroupScheduleTileListBuilder extends ConsumerStatefulWidget {
  const GroupScheduleTileListBuilder({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final String groupId;
  final String groupName;

  @override
  ConsumerState<GroupScheduleTileListBuilder> createState() =>
      _GroupScheduleTileListBuilderState();
}

class _GroupScheduleTileListBuilderState
    extends ConsumerState<GroupScheduleTileListBuilder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout();
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout();
        } else {
          return _buildDesktopLayout();
        }
      },
    );
  }

  Widget _buildMobileLayout() {
    return _buildLayout(
      mainAxisSpacing: 8,
      childAspectRatio: 6.5,
    );
  }

  Widget _buildTabletLayout() {
    return _buildLayout(
      mainAxisSpacing: 8,
      childAspectRatio: 10,
    );
  }

  Widget _buildDesktopLayout() {
    return _buildLayout(
      mainAxisSpacing: 8,
      childAspectRatio: 10,
    );
  }

  Widget _buildLayout({
    required double mainAxisSpacing,
    required double childAspectRatio,
  }) {
    final tileList = ref.watch(
      groupScheduleTileListBuilderNotifierProvider(
        (widget.groupId, widget.groupName),
      ),
    );

    return GridView.count(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: mainAxisSpacing,
      children: tileList,
    );
  }
}

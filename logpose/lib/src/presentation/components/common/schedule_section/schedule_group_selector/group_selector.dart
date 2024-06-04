import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/responsive_util.dart';

import '../../../../providers/group/group/listen_joined_group_profile_provider.dart';

import 'components/group_picker_button.dart';
import 'components/group_selector_icon.dart';

class GroupSelector extends ConsumerStatefulWidget {
  const GroupSelector({super.key});

  @override
  ConsumerState<GroupSelector> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends ConsumerState<GroupSelector> {
  Widget _buildGroupIdList(double paddingTop, double maxWidth) {
    final asyncGroupsIdList = ref.watch(listenJoinedGroupIdListProvider);

    return asyncGroupsIdList.when(
      data: (data) {
        return Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: Row(
            children: [
              const GroupSelectorIcon(),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: GroupPickerButton(groupIdList: data),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }

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
      paddingTop: deviceHeight * 0.01,
      maxWidth: deviceWidth * 0.6,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.02,
      maxWidth: deviceWidth * 0.6,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.035,
      maxWidth: deviceWidth * 0.6,
    );
  }

  Widget _buildLayout({
    required double paddingTop,
    required double maxWidth,
  }) {
    return _buildGroupIdList(paddingTop, maxWidth);
  }
}

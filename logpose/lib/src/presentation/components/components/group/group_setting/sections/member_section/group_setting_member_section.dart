import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';

import '../../../../../common/member_switch/member_addition_switch.dart';
import '../../../../../common/member_switch/member_deletion_switch.dart';

import 'components/group_setting_member_panel.dart';

class GroupSettingMemberSection extends ConsumerStatefulWidget {
  const GroupSettingMemberSection({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState createState() => _GroupSettingMemberSectionState();
}

class _GroupSettingMemberSectionState
    extends ConsumerState<GroupSettingMemberSection> {
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
      sizedBoxWidth: deviceWidth * 0.89,
      sizedBoxHeight: deviceHeight * 0.11,
      additionSwitchPositionTop: deviceHeight * -0.0165,
      deletionSwitchPositionTop: deviceHeight * 0.032,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      sizedBoxWidth: deviceWidth * 0.89,
      sizedBoxHeight: deviceHeight * 0.2,
      additionSwitchPositionTop: deviceHeight * -0.01,
      deletionSwitchPositionTop: deviceHeight * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      sizedBoxWidth: deviceWidth * 0.89,
      sizedBoxHeight: deviceHeight * 0.2,
      additionSwitchPositionTop: deviceHeight * -0.005,
      deletionSwitchPositionTop: deviceHeight * 0.05,
    );
  }

  Widget _buildLayout({
    required double sizedBoxWidth,
    required double sizedBoxHeight,
    required double additionSwitchPositionTop,
    required double deletionSwitchPositionTop,
  }) {
    final groupId = widget.groupId;

    return SizedBox(
      width: sizedBoxWidth,
      height: sizedBoxHeight,
      child: Stack(
        children: [
          GroupSettingMemberPanel(groupId: groupId),
          Positioned(
            top: additionSwitchPositionTop,
            right: -15,
            child: MemberAdditionSwitch(groupId: groupId),
          ),
          Positioned(
            top: deletionSwitchPositionTop,
            right: -15,
            child: MemberDeletionSwitch(
              groupId: groupId,
              type: GroupManagementType.setting,
            ),
          ),
        ],
      ),
    );
  }
}

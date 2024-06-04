import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/responsive_util.dart';

import '../../../handlers/member_delete_switch_handler.dart';

enum GroupManagementType { create, setting }

class MemberDeletionSwitch extends ConsumerStatefulWidget {
  const MemberDeletionSwitch({super.key, this.groupId, required this.type});

  final String? groupId;
  final GroupManagementType type;

  @override
  ConsumerState<MemberDeletionSwitch> createState() =>
      _MemberDeletionSwitchState();
}

class _MemberDeletionSwitchState extends ConsumerState<MemberDeletionSwitch> {
  Future<void> _handleToTap() async {
    widget.type == GroupManagementType.create
        ? await _handleDeleteSwitchOfCreation()
        : await _handleDeleteSwitchOfSetting();
  }

  Future<void> _handleDeleteSwitchOfCreation() async {
    final handler = MemberDeleteSwitchHandler(
      context: context,
      ref: ref,
      groupId: widget.groupId,
    );
    await handler.handleDeleteSwitchOfCreation();
  }

  Future<void> _handleDeleteSwitchOfSetting() async {
    final handler = MemberDeleteSwitchHandler(
      context: context,
      ref: ref,
      groupId: widget.groupId,
    );
    await handler.handleDeleteSwitchOfSetting();
  }

  @override
  Widget build(BuildContext context) {
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
      containerSize: deviceWidth * 0.09,
      addIconSize: deviceWidth * 0.055,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      containerSize: deviceWidth * 0.065,
      addIconSize: deviceWidth * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      containerSize: deviceWidth * 0.045,
      addIconSize: deviceWidth * 0.03,
    );
  }

  Widget _buildLayout({
    required double containerSize,
    required double addIconSize,
  }) {
    return CupertinoButton(
      onPressed: _handleToTap,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: const Color(0xFFEB6161),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.person_badge_minus_fill,
            size: addIconSize,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}

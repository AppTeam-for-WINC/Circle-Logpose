import 'package:flutter/cupertino.dart';

import '../../../../../utils/responsive_util.dart';

import '../../../navigations/modals/to_addition_navigator.dart';

class MemberAdditionSwitch extends StatefulWidget {
  const MemberAdditionSwitch({super.key, this.groupId});

  final String? groupId;

  @override
  State<MemberAdditionSwitch> createState() => _MemberAdditionSwitchState();
}

class _MemberAdditionSwitchState extends State<MemberAdditionSwitch> {
  Future<void> handleToTap() async {
    final navigator = ToMemberAdditionNavigator(context);
    await navigator.showModal(widget.groupId);
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
      onPressed: handleToTap,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: const Color(0xFFD8EB61),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.person_add_solid,
            size: addIconSize,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../../handlers/schedule_addition_switch_handler.dart';

class ScheduleAdditionSwitch extends ConsumerStatefulWidget {
  const ScheduleAdditionSwitch({
    super.key,
    required this.groupId,
    this.groupName,
  });

  final String groupId;
  final String? groupName;

  @override
  ConsumerState<ScheduleAdditionSwitch> createState() =>
      _ScheduleAdditionSwitchState();
}

class _ScheduleAdditionSwitchState
    extends ConsumerState<ScheduleAdditionSwitch> {
  Future<void> handleTap() async {
    final handler = ScheduleAdditionSwitchHandler(
      context,
      ref,
      widget.groupId,
      widget.groupName!,
    );

    await handler.handleSwitch();
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
      containerSize: deviceWidth * 0.1,
      addIconSize: deviceWidth * 0.06,
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
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: const Color(0xFFD8EB61),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.calendar_badge_plus,
            size: addIconSize,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}

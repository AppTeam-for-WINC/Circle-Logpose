import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../../handlers/schedule_delete_switch_handler.dart';

class ScheduleDeletionSwitch extends ConsumerStatefulWidget {
  const ScheduleDeletionSwitch({super.key});

  @override
  ConsumerState<ScheduleDeletionSwitch> createState() =>
      _ScheduleDeletionSwitchState();
}

class _ScheduleDeletionSwitchState
    extends ConsumerState<ScheduleDeletionSwitch> {
  Future<void> handleTap() async {
    final handler = ScheduleDeleteSwitchHandler(ref);
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
          color: const Color(0xFFEB6161),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.calendar_badge_minus,
            size: addIconSize,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}

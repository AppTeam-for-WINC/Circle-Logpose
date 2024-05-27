import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../navigations/modals/to_schedule_detail_confirm_navigator.dart';

class ScheduleDetailConfirmationButton extends ConsumerStatefulWidget {
  const ScheduleDetailConfirmationButton({
    super.key,
    required this.groupScheduleId,
    required this.groupProfile,
    required this.groupSchedule,
  });

  final String groupScheduleId;
  final GroupProfile groupProfile;
  final GroupSchedule groupSchedule;

  @override
  ConsumerState<ScheduleDetailConfirmationButton> createState() =>
      _ScheduleDetailConfirmationButtonState();
}

class _ScheduleDetailConfirmationButtonState
    extends ConsumerState<ScheduleDetailConfirmationButton> {
  Future<void> handleToTap() async {
    final navigator = ToScheduleDetailConfirmNavigator(context, ref);
    await navigator.showModal(
      groupScheduleId: widget.groupScheduleId,
      groupProfile: widget.groupProfile,
      groupSchedule: widget.groupSchedule,
    );
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
      titleMaxWidth: deviceWidth * 0.35,
      titleTextSize: deviceWidth * 0.044,
      chevronSize: deviceWidth * 0.044,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      titleMaxWidth: deviceWidth * 0.35,
      titleTextSize: deviceWidth * 0.026,
      chevronSize: deviceWidth * 0.026,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      titleMaxWidth: deviceWidth * 0.044,
      titleTextSize: deviceWidth * 0.024,
      chevronSize: deviceWidth * 0.024,
    );
  }

  Widget _buildLayout({
    required double titleMaxWidth,
    required double titleTextSize,
    required double chevronSize,
  }) {
    return GestureDetector(
      onTap: handleToTap,
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: titleMaxWidth),
            child: Text(
              widget.groupSchedule.title,
              textAlign: TextAlign.end,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: titleTextSize,
              ),
            ),
          ),
          Icon(
            CupertinoIcons.right_chevron,
            size: chevronSize,
            color: const Color(0xFF7B61FF),
          ),
        ],
      ),
    );
  }
}

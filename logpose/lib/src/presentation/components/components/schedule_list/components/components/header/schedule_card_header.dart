import 'package:flutter/cupertino.dart';

import '../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../utils/responsive_util.dart';

import 'components/schdule_card_time_view.dart';
import 'components/schedule_detail_confirmation_button.dart';

class ScheduleCardHeader extends StatelessWidget {
  const ScheduleCardHeader({
    super.key,
    required this.groupSchedule,
    required this.groupScheduleId,
    required this.groupProfile,
  });

  final GroupSchedule groupSchedule;
  final String groupScheduleId;
  final GroupProfile groupProfile;

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
      padding: [22, 10],
      marginTop: deviceWidth * 0.09,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      padding: [32, 22],
      marginTop: deviceWidth * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      padding: [32, 32],
      marginTop: deviceWidth * 0.035,
    );
  }

  Widget _buildLayout({
    required List<double> padding,
    required double marginTop,
  }) {
    return Container(
      padding: EdgeInsets.only(left: padding[0], right: padding[1]),
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScheduleCardTimeView(groupSchedule: groupSchedule),
          ScheduleDetailConfirmationButton(
            groupScheduleId: groupScheduleId,
            groupProfile: groupProfile,
            groupSchedule: groupSchedule,
          ),
        ],
      ),
    );
  }
}

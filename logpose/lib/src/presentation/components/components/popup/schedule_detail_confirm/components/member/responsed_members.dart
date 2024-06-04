import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../utils/responsive_util.dart';
import '../../../../../../navigations/modals/to_join_schedule_view_navigator.dart';
import '../../../../../common/schedule_view_label.dart';
import 'components/join_schedule_group_member_image_list.dart';

class ResponsedMembers extends ConsumerStatefulWidget {
  const ResponsedMembers({
    super.key,
    required this.groupProfile,
    required this.scheduleId,
    required this.groupSchedule,
  });

  final GroupProfile groupProfile;
  final String scheduleId;
  final GroupSchedule groupSchedule;

  @override
  ConsumerState createState() => _ResponsedMembersState();
}

class _ResponsedMembersState extends ConsumerState<ResponsedMembers> {
  Future<void> _handleToTap() async {
    final navigator = ToJoinScheduleViewNavigator(context, ref);
    await navigator.showModal(
      scheduleId: widget.scheduleId,
      groupProfile: widget.groupProfile,
      groupSchedule: widget.groupSchedule,
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
      marginTop: deviceHeight * 0.04,
      iconSize: deviceWidth * 0.032,
      textSize: deviceWidth * 0.03,
      imageSize: deviceWidth * 0.06,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      marginTop: deviceHeight * 0.04,
      iconSize: deviceWidth * 0.022,
      textSize: deviceWidth * 0.02,
      imageSize: deviceWidth * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      marginTop: deviceHeight * 0.04,
      iconSize: deviceWidth * 0.018,
      textSize: deviceWidth * 0.015,
      imageSize: deviceWidth * 0.04,
    );
  }

  Widget _buildLayout({
    required double marginTop,
    required double iconSize,
    required double textSize,
    required double imageSize,
  }) {
    return GestureDetector(
      onTap: _handleToTap,
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        child: Row(
          children: [
            const ScheduleViewLabel(
              label: '参加メンバー |',
              icon: CupertinoIcons.group,
            ),
            JoinScheduleGroupMemberImageList(
              scheduleId: widget.scheduleId,
              imageSize: imageSize,
            ),
          ],
        ),
      ),
    );
  }
}

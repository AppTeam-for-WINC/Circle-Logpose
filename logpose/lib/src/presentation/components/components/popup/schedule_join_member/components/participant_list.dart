import 'package:flutter/cupertino.dart';

import '../../../../../../../utils/responsive_util.dart';

import '../../../../../../domain/entity/user_profile.dart';

import 'components/member_and_attendance_tile.dart';
import 'components/participant_list_label.dart';

class ParticipantList extends StatelessWidget {
  const ParticipantList({
    super.key,
    required this.memberProfileList,
    required this.scheduleId,
  });

  final List<UserProfile?> memberProfileList;
  final String scheduleId;

  List<Widget> buildMemberAndAttendanceTile() {
    return memberProfileList.whereType<UserProfile>().map((userProfile) {
      return MemberAndAttendanceTile(
        scheduleId: scheduleId,
        userProfile: userProfile,
      );
    }).toList();
  }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ParticipantListLabel(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: GridView.count(
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
            crossAxisCount: 1,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            children: buildMemberAndAttendanceTile(),
          ),
        ),
      ],
    );
  }
}

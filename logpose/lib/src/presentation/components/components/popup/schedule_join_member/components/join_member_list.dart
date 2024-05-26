import 'package:flutter/cupertino.dart';

import '../../../../../../domain/entity/user_profile.dart';

import 'components/join_member_list_label.dart';
import 'components/member_and_attendance_tile.dart';

class JoinMemberList extends StatelessWidget {
  const JoinMemberList({
    super.key,
    required this.memberProfileList,
    required this.scheduleId,
  });

  final List<UserProfile?> memberProfileList;
  final String scheduleId;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    List<Widget> buildMemberAndAttendanceTile() {
      return memberProfileList.whereType<UserProfile>().map((userProfile) {
        return MemberAndAttendanceTile(
          scheduleId: scheduleId,
          userProfile: userProfile,
        );
      }).toList();
    }

    return Column(
      children: [
        const JoinMemberListLabel(),
        Container(
          width: deviceWidth * 0.7,
          height: deviceHeight * 0.35,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: GridView.count(
            mainAxisSpacing: 8,
            childAspectRatio: 5.5,
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

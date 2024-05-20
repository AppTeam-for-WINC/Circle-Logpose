import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/entity/group_profile.dart';
import '../../../../../domain/entity/group_schedule.dart';
import '../../../../../domain/entity/user_profile.dart';

import '../../../common/back_to_page_button.dart';

import '../components/background/background.dart';
import '../components/schedule_time_view/schedule_time_view.dart';

import 'components/member/join_members.dart';
import 'components/title/schedule_title.dart';

class ScheduleJoinMember extends ConsumerStatefulWidget {
  const ScheduleJoinMember({
    super.key,
    required this.groupProfile,
    required this.memberProfiles,
    required this.scheduleId,
    required this.groupSchedule,
  });

  final String scheduleId;
  final GroupProfile groupProfile;
  final List<UserProfile?> memberProfiles;
  final GroupSchedule groupSchedule;
  @override
  ConsumerState<ScheduleJoinMember> createState() {
    return ScheduleJoinMemberState();
  }
}

class ScheduleJoinMemberState extends ConsumerState<ScheduleJoinMember> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final memberProfiles = widget.memberProfiles;
    final scheduleId = widget.scheduleId;
    final groupSchedule = widget.groupSchedule;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: deviceWidth * 0.06,
          right: deviceWidth * 0.06,
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight * 0.55,
              child: Stack(
                children: [
                  const Background(),
                  const BackToPageButton(),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScheduleTitle(title: groupSchedule.title),
                        ScheduleTimeView(groupSchedule: groupSchedule),
                        JoinMembers(
                          memberProfiles: memberProfiles,
                          scheduleId: scheduleId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
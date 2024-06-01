import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/entity/group_profile.dart';
import '../../../../../domain/entity/group_schedule.dart';
import '../../../../../domain/entity/user_profile.dart';

import '../../../common/back_to_page_button.dart';
import '../../../common/background.dart';
import '../../../common/schedule_time_view.dart';
import '../../../common/schedule_title_view.dart';

import 'components/join_member_list.dart';

class JoinScheduleView extends ConsumerStatefulWidget {
  const JoinScheduleView({
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
  ConsumerState<JoinScheduleView> createState() => _JoinScheduleViewState();
}

class _JoinScheduleViewState extends ConsumerState<JoinScheduleView> {
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
                  const PopupBackground(),
                  const BackToPageButton(iconColor: Color(0xFF7B61FF),),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScheduleTitleView(
                          title: groupSchedule.title,
                          marginTop: 60,
                          fontSize: 30,
                        ),
                        ScheduleTimeView(groupSchedule: groupSchedule),
                        JoinMemberList(
                          memberProfileList: memberProfiles,
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

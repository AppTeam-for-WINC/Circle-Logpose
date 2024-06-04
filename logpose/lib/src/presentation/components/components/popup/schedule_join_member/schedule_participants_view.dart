import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/entity/group_profile.dart';
import '../../../../../domain/entity/group_schedule.dart';
import '../../../../../domain/entity/user_profile.dart';

import '../../../common/back_to_page_button.dart';
import '../../../common/popup_background.dart';
import '../../../common/schedule_time_view.dart';
import '../../../common/schedule_title_view.dart';

import 'components/participant_list.dart';

class ScheduleParticipantsView extends ConsumerStatefulWidget {
  const ScheduleParticipantsView({
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
  ConsumerState<ScheduleParticipantsView> createState() =>
      _ScheduleParticipantsViewState();
}

class _ScheduleParticipantsViewState
    extends ConsumerState<ScheduleParticipantsView> {
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
                  const BackToPageButton(iconColor: Color(0xFF7B61FF)),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScheduleTitleView(title: groupSchedule.title),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ScheduleTimeView(groupSchedule: groupSchedule),
                        ),
                        ParticipantList(
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

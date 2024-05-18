import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../../../domain/providers/group/schedule/group_member_schedule_provider.dart';

import '../../../common/custom_image/custom_image.dart';

import 'components/absence/absence_button.dart';
import 'components/attendance/attendance_button.dart';
import 'components/date_label/date_label.dart';
import 'components/lateness/lateness_button.dart';
import 'components/leave_early/leave_early_button.dart';
import 'components/move_to_page/schedule_detail_confirm_button.dart';
import 'components/time_view/schdule_card_time_view.dart';

class ScheduleCard extends ConsumerStatefulWidget {
  const ScheduleCard({super.key, required this.groupData});
  final GroupProfileAndScheduleAndId groupData;
  @override
  ConsumerState<ScheduleCard> createState() {
    return _GroupScheduleCardState();
  }
}

class _GroupScheduleCardState extends ConsumerState<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupProfileAndScheduleAndId = widget.groupData;
    final groupProfile = widget.groupData.groupProfile;
    final groupImage = widget.groupData.groupProfile.image;
    final groupSchedule = widget.groupData.groupSchedule;
    final groupScheduleId = widget.groupData.groupScheduleId;
    final userSchedule =
        ref.watch(groupMemberScheduleProvider(groupScheduleId));
    final isAttendance = userSchedule?.attendance ?? false;
    final isLeaveEarly = userSchedule?.leaveEarly ?? false;
    final isLateness = userSchedule?.lateness ?? false;
    final isAbsence = userSchedule?.absence ?? false;

    return Container(
      width: deviceWidth * 0.88,
      height: deviceHeight * 0.215,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 19,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: CupertinoColors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 10,
                    ),
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScheduleCardTimeView(groupSchedule: groupSchedule),
                        ScheduleDetailConfirmButton(
                          groupScheduleId: groupScheduleId,
                          groupProfile: groupProfile,
                          groupSchedule: groupSchedule,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AttendanceButton(
                          isAttendance: isAttendance,
                          groupScheduleId: groupScheduleId,
                          groupSchedule: groupSchedule,
                        ),
                        LeaveEarlyButton(
                          isLeaveEarly: isLeaveEarly,
                          groupScheduleId: groupScheduleId,
                          groupProfileAndScheduleAndId:
                              groupProfileAndScheduleAndId,
                        ),
                        LatenessButton(
                          isLateness: isLateness,
                          groupScheduleId: groupScheduleId,
                          groupProfileAndScheduleAndId:
                              groupProfileAndScheduleAndId,
                        ),
                        AbsenceButton(
                          isAbsence: isAbsence,
                          groupScheduleId: groupScheduleId,
                          groupSchedule: groupSchedule,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 5,
            child: DateLabel(groupSchedule: groupSchedule),
          ),
          Positioned(
            right: 35,
            child: CustomImage(imagePath: groupImage, width: 42, height: 42),
          ),
        ],
      ),
    );
  }
}

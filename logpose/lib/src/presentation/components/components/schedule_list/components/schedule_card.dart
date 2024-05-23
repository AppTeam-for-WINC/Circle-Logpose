import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../../notifiers/group_member_schedule_notifier.dart';

import '../../../common/custom_image/custom_image.dart';

import 'components/date_label.dart';
import 'components/header/schedule_card_header.dart';
import 'components/response_buttons/response_buttons.dart';

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
        ref.watch(groupMemberScheduleNotifierProvider(groupScheduleId));
    final isAttendance = userSchedule?.attendance ?? false;
    final isLeaveEarly = userSchedule?.leaveEarly ?? false;
    final isLateness = userSchedule?.lateness ?? false;
    final isAbsence = userSchedule?.absence ?? false;

    return Container(
      width: deviceWidth * 0.88,
      height: deviceHeight * 0.215,
      margin: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 19),
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
                  ScheduleCardHeader(
                    groupSchedule: groupSchedule,
                    groupScheduleId: groupScheduleId,
                    groupProfile: groupProfile,
                  ),
                  ResponseButtons(
                    groupScheduleId: groupScheduleId,
                    groupProfile: groupProfile,
                    groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
                    isAttendance: isAttendance,
                    isLeaveEarly: isLeaveEarly,
                    isLateness: isLateness,
                    isAbsence: isAbsence,
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

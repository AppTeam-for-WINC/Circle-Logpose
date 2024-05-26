import 'package:flutter/cupertino.dart';

import '../../../../../../../domain/entity/group_profile.dart';

import '../../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';
import 'components/components/absence_button.dart';
import 'components/components/attendance_button.dart';
import 'components/components/lateness_button.dart';
import 'components/components/leave_early_button.dart';

class ResponseButtons extends StatelessWidget {
  const ResponseButtons({
    super.key,
    required this.groupScheduleId,
    required this.groupProfile,
    required this.groupProfileAndScheduleAndId,
    required this.isAttendance,
    required this.isLeaveEarly,
    required this.isLateness,
    required this.isAbsence,
  });

  final String groupScheduleId;
  final GroupProfile groupProfile;
  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;
  final bool isAttendance;
  final bool isLeaveEarly;
  final bool isLateness;
  final bool isAbsence;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AttendanceButton(
            isAttendance: isAttendance,
            groupScheduleId: groupScheduleId,
          ),
          LeaveEarlyButton(
            isLeaveEarly: isLeaveEarly,
            groupScheduleId: groupScheduleId,
            groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
          ),
          LatenessButton(
            isLateness: isLateness,
            groupScheduleId: groupScheduleId,
            groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
          ),
          AbsenceButton(
            isAbsence: isAbsence,
            groupScheduleId: groupScheduleId,
          ),
        ],
      ),
    );
  }
}

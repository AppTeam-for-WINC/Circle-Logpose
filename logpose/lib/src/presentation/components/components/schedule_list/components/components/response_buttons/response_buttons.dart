import 'package:flutter/cupertino.dart';

import '../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../domain/entity/group_profile.dart';

import '../../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import 'components/absence_button.dart';
import 'components/attendance_button.dart';
import 'components/lateness_button.dart';
import 'components/leave_early_button.dart';

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
    return _buildLayout([deviceWidth * 0.028, deviceWidth * 0.03]);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout([deviceWidth * 0.03, deviceWidth * 0.03]);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout([deviceWidth * 0.02, deviceWidth * 0.03]);
  }

  Widget _buildLayout(List<double> margin) {
    return Container(
      margin: EdgeInsets.only(
        top: margin[0],
        left: margin[1],
        right: margin[1],
      ),
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

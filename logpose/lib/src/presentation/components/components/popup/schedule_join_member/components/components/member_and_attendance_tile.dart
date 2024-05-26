import 'package:flutter/material.dart';

import '../../../../../../../domain/entity/user_profile.dart';

import 'components/member_and_attendance.dart';

class MemberAndAttendanceTile extends StatelessWidget {
  const MemberAndAttendanceTile({
    super.key,
    required this.scheduleId,
    required this.userProfile,
  });

  final String scheduleId;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(1, 1),
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromARGB(255, 248, 233, 255),
        ),
        child: MemberAndAttendance(
          scheduleId: scheduleId,
          userProfile: userProfile,
        ),
      ),
    );
  }
}

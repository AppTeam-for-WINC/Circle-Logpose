import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../common/custom_image/custom_image.dart';

import '../../../../components/user_name/user_name.dart';
import 'components/async_member_schedule.dart';

class MemberAndAttendance extends ConsumerStatefulWidget {
  const MemberAndAttendance({
    super.key,
    required this.scheduleId,
    required this.userProfile,
  });
  final String scheduleId;
  final UserProfile userProfile;

  @override
  ConsumerState<MemberAndAttendance> createState() =>
      _MemberAndAttendanceState();
}

class _MemberAndAttendanceState extends ConsumerState<MemberAndAttendance> {
  @override
  Widget build(BuildContext context) {
    final scheduleId = widget.scheduleId;
    final userProfile = widget.userProfile;

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
        child: Container(
          padding: const EdgeInsets.only(left: 3),
          margin: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CustomImage(
                      imagePath: userProfile.image,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Username(name: userProfile.name),
                ],
              ),
              AsyncMemberSchedule(
                scheduleId: scheduleId,
                accountId: userProfile.accountId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

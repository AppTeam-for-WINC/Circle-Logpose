import 'package:flutter/material.dart';

import '../../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../common/custom_image/custom_image.dart';
import '../../../../../../common/user_name.dart';

import 'components/member_join_time.dart';

class MemberAndAttendance extends StatelessWidget {
  const MemberAndAttendance({
    super.key,
    required this.scheduleId,
    required this.userProfile,
  });

  final String scheduleId;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          MemberJoinTime(
            scheduleId: scheduleId,
            accountId: userProfile.accountId,
          ),
        ],
      ),
    );
  }
}

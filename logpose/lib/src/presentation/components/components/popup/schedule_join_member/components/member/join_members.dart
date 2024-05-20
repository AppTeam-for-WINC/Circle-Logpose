import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/user_profile.dart';
import 'components/member_and_attendance.dart';

class JoinMembers extends ConsumerWidget {
  const JoinMembers({
    super.key,
    required this.memberProfiles,
    required this.scheduleId,
  });
  final List<UserProfile?> memberProfiles;
  final String scheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: const Row(
            children: [
              Icon(CupertinoIcons.group, size: 25),
              SizedBox(width: 10),
              Text(
                '参加メンバー',
                style: TextStyle(color: CupertinoColors.black),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            width: deviceWidth * 0.7,
            height: deviceHeight * 0.2,
            padding: const EdgeInsets.only(
              right: 5,
              left: 5,
              bottom: 5,
            ),
            child: GridView.count(
              mainAxisSpacing: 8,
              childAspectRatio: 5.5,
              crossAxisCount: 1,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              children: [
                ...memberProfiles.whereType<UserProfile>().map((userProfile) {
                  return MemberAndAttendance(
                    scheduleId: scheduleId,
                    userProfile: userProfile,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

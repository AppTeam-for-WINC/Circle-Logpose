import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/group/database/group.dart';
import '../../../../../models/group/database/group_schedule.dart';
import '../../../group/setting/parts/group_member_image.dart';
import '../../schedule_join_member/schedule_join_member.dart';
import 'reaponsed_member_controller.dart';

class ResponsedMembers extends ConsumerStatefulWidget {
  const ResponsedMembers({
    super.key,
    required this.groupProfile,
    required this.scheduleId,
    required this.schedule,
  });

  final GroupProfile groupProfile;
  final String scheduleId;
  final GroupSchedule schedule;
  @override
  ConsumerState createState() => _ResponsedMemberState();
}

class _ResponsedMemberState extends ConsumerState<ResponsedMembers> {
  @override
  Widget build(BuildContext context) {
    final groupProfile = widget.groupProfile;
    final scheduleId = widget.scheduleId;
    final schedule = widget.schedule;

    final asyncGroupMember =
        ref.watch(groupMembershipProfileListNotAbsenceListProvider(scheduleId));

    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<ScheduleJoinMember>(
          context: context,
          builder: (BuildContext context) {
            return asyncGroupMember.when(
              data: (membershipProfileList) {
                return ScheduleJoinMember(
                  groupProfile: groupProfile,
                  memberProfiles: membershipProfileList,
                  scheduleId: scheduleId,
                  schedule: schedule,
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => Text('$error'),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            const Icon(
              Icons.group,
              size: 25,
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Text(
                '参加メンバー |',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            asyncGroupMember.when(
              data: (membershipProfileList) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Row(
                    children: membershipProfileList.map((membershipProfile) {
                      return membershipProfile != null
                          ? GroupMemberImage(
                              userProfile: membershipProfile,
                            )
                          : const SizedBox.shrink();
                    }).toList(),
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => Text('$error'),
            ),
          ],
        ),
      ),
    );
  }
}

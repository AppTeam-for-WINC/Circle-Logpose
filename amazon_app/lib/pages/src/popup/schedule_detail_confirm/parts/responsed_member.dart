import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:amazon_app/pages/src/group/setting/parts/group_member_image.dart';
import 'package:amazon_app/pages/src/popup/schedule_detail_confirm/parts/reaponsed_member_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_join_member/schedule_join_member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final groupMember =
        ref.watch(groupMembershipProfileListNotAbsenceProvider(scheduleId));

    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<ScheduleJoinMember>(
          context: context,
          builder: (BuildContext context) {
            return groupMember.when(
              data: (membershipProfiles) {
                return ScheduleJoinMember(
                  memberProfiles: membershipProfiles,
                  groupProfile: groupProfile,
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
            groupMember.when(
              data: (membershipProfiles) {
                return Column(
                  children: membershipProfiles.map((membershipProfile) {
                    return membershipProfile != null
                        ? GroupMemberImage(
                            userProfile: membershipProfile,
                          )
                        : const SizedBox.shrink();
                  }).toList(),
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

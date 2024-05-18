import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../domain/entity/group_schedule.dart';


import '../../../../../../../domain/providers/group/schedule/watch_group_member_profile_not_absence_list_provider.dart';


import '../../../schedule_join_member/schedule_join_member.dart';
import 'components/async_group_member.dart';

class ResponsedMembers extends ConsumerStatefulWidget {
  const ResponsedMembers({
    super.key,
    required this.groupProfile,
    required this.scheduleId,
    required this.groupSchedule,
  });

  final GroupProfile groupProfile;
  final String scheduleId;
  final GroupSchedule groupSchedule;
  @override
  ConsumerState createState() => _ResponsedMembersState();
}

class _ResponsedMembersState extends ConsumerState<ResponsedMembers> {
  Future<void> _onTap() async {
    final scheduleId = widget.scheduleId;
    final asyncGroupMember = ref.watch(
      watchGroupMembershipProfileNotAbsenceListProvider(scheduleId),
    );
    await showCupertinoModalPopup<ScheduleJoinMember>(
      context: context,
      builder: (BuildContext context) {
        return asyncGroupMember.when(
          data: (membershipProfileList) {
            return ScheduleJoinMember(
              groupProfile: widget.groupProfile,
              memberProfiles: membershipProfileList,
              scheduleId: scheduleId,
              groupSchedule: widget.groupSchedule,
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => Text('$error'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.group,
              size: 25,
              color: CupertinoColors.systemGrey,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Text(
                '参加メンバー |',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            AsyncGroupMember(scheduleId: widget.scheduleId),
          ],
        ),
      ),
    );
  }
}

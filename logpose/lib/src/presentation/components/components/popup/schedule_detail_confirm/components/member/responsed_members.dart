import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../navigations/modals/responsed_members_modal_navigator.dart';
import 'components/join_schedule_group_member_image_list.dart';

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
  Future<void> _handleToTap() async {
    final navigator = ResponsedMemebersModalNavigator(context, ref);
    await navigator.showModal(
      scheduleId: widget.scheduleId,
      groupProfile: widget.groupProfile,
      groupSchedule: widget.groupSchedule,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleToTap,
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
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
            ),
            JoinScheduleGroupMemberImageList(scheduleId: widget.scheduleId),
          ],
        ),
      ),
    );
  }
}

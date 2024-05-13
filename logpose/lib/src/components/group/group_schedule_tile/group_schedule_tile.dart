import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/group/mode/schedule_delete_mode_provider.dart';
import '../../../controllers/providers/group/text/selected_group_name_provider.dart';

import '../../../models/custom/group_schedule_and_id_model.dart';
import '../../../models/database/user/user.dart';

import '../../popup/update_schedule/update_schedule.dart';
import 'components/delete_group_schedule_button.dart';

class GroupScheduleTile extends ConsumerStatefulWidget {
  const GroupScheduleTile({
    super.key,
    required this.schedule,
    required this.groupName,
    required this.groupMemberList,
  });
  final GroupScheduleAndId schedule;
  final String groupName;
  final List<UserProfile?> groupMemberList;
  
  @override
  ConsumerState<GroupScheduleTile> createState() => _ScheduleComponentState();
}

class _ScheduleComponentState extends ConsumerState<GroupScheduleTile> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final groupScheduleId = widget.schedule.groupScheduleId;
    final groupSchedule = widget.schedule.groupSchedule;
    final groupName = widget.groupName;
    final groupMemberList = widget.groupMemberList;

    Future<void> onTap() async {
      ref.watch(selectedGroupNameProvider.notifier).state = groupName;
      await showCupertinoModalPopup<UpdateSchedule>(
        context: context,
        builder: (BuildContext context) {
          return UpdateSchedule(
            groupScheduleId: groupScheduleId,
          );
        },
      );
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 244, 219, 251),
              borderRadius: BorderRadius.circular(80),
            ),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
                  child: Text(
                    groupSchedule.title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 69, 68, 68),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (ref.watch(scheduleDeleteModeProvider))
          Positioned(
            top: -8,
            right: 0,
            child: DeleteGroupScheduleButton(
              groupMemberList: groupMemberList,
              groupScheduleId: groupScheduleId,
            ),
          ),
      ],
    );
  }
}

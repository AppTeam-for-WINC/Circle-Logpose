import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../../../../../domain/model/group_schedule_and_id_model.dart';

import '../../../../../../../../../handlers/group_schedule_tile_handler.dart';

import '../../../../../../../../../providers/group/mode/schedule_delete_mode_provider.dart';

import 'components/group_schedule_delete_button.dart';
import 'components/group_schedule_tile_title_label.dart';

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
  ConsumerState<GroupScheduleTile> createState() => _GroupScheduleTileState();
}

class _GroupScheduleTileState extends ConsumerState<GroupScheduleTile> {
  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.schedule.groupScheduleId;
    final groupSchedule = widget.schedule.groupSchedule;
    final groupName = widget.groupName;
    final groupMemberList = widget.groupMemberList;

    Future<void> handleToTap() async {
      final handler = GroupScheduleTileHandler(
        context: context,
        ref: ref,
        groupName: groupName,
        groupScheduleId: groupScheduleId,
      );

      await handler.handleTile();
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: handleToTap,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 244, 219, 251),
              borderRadius: BorderRadius.circular(80),
            ),
            child: GroupScheduleTileTitleLabel(title: groupSchedule.title),
          ),
        ),
        if (ref.watch(scheduleDeleteModeProvider))
          Positioned(
            top: -8,
            right: 0,
            child: GroupScheduleDeleteButton(
              groupMemberList: groupMemberList,
              groupScheduleId: groupScheduleId,
            ),
          ),
      ],
    );
  }
}

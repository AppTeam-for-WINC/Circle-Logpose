import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/mode/schedule_delete_mode_provider.dart';
import '../../../../../controllers/providers/group/name/selected_group_name_provider.dart';
import '../../../../../controllers/src/group/delete/delete_schedule.dart';
import '../../../../../models/group/group_schedule_and_id_model.dart';
import '../../../../../models/user/user.dart';

import '../../../popup/schedule_setting/update_schedule.dart';

class ScheduleComponent extends ConsumerStatefulWidget {
  const ScheduleComponent({
    super.key,
    required this.groupId,
    required this.schedule,
    required this.groupName,
    required this.groupMemberList,
  });

  final String groupId;
  final GroupScheduleAndId schedule;
  final String groupName;
  final List<UserProfile?> groupMemberList;
  @override
  ConsumerState<ScheduleComponent> createState() => _ScheduleComponentState();
}

class _ScheduleComponentState extends ConsumerState<ScheduleComponent> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final groupId = widget.groupId;
    final groupScheduleId = widget.schedule.groupScheduleId;
    final groupSchedule = widget.schedule.groupSchedule;
    final groupName = widget.groupName;
    final groupMemberList = widget.groupMemberList;

    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            ref.watch(selectedGroupNameProvider.notifier).state = groupName;
            await showCupertinoModalPopup<ScheduleUpdate>(
              context: context,
              builder: (BuildContext context) {
                return ScheduleUpdate(
                  groupScheduleId: groupScheduleId,
                );
              },
            );
          },
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
                  constraints: BoxConstraints(
                    maxWidth: deviceWidth * 0.6,
                  ),
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
            child: CupertinoButton(
              onPressed: () async {
                await DeleteSchedule.delete(
                  groupId,
                  groupScheduleId,
                  groupMemberList,
                );
              },
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

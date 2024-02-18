import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/user/user.dart';

import '../../../popup/schedule_create/schedule_create_controller.dart';
import '../../../popup/schedule_setting/schedule_change.dart';
import '../group_setting_controller.dart';
import 'schedule_card_controller.dart';

class ScheduleCard extends ConsumerStatefulWidget {
  const ScheduleCard({
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
  ConsumerState<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends ConsumerState<ScheduleCard> {
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
            ref.watch(groupNameProvider.notifier).state = groupName;
            await showCupertinoModalPopup<ScheduleChange>(
              context: context,
              builder: (BuildContext context) {
                return ScheduleChange(
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

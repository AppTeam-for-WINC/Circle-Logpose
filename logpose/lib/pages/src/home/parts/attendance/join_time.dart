import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controller/common/time_controller.dart';
import 'join_time_picker.dart';
import 'user_schedule_controller.dart';

class ScheduleJoinTime extends ConsumerStatefulWidget {
  const ScheduleJoinTime({
    super.key,
    required this.groupProfileWithScheduleWithId,
  });

  final GroupProfileWithScheduleWithId groupProfileWithScheduleWithId;
  @override
  ConsumerState createState() => _ScheduleJoinTimeState();
}

class _ScheduleJoinTimeState extends ConsumerState<ScheduleJoinTime> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.groupProfileWithScheduleWithId.groupSchedule;
    final groupScheduleId =
        widget.groupProfileWithScheduleWithId.groupScheduleId;
    final schedule = ref.watch(setMemberScheduleProvider(groupScheduleId));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.schedule),
            Text(
              '参加時間',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CupertinoButton(
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return JoinScheduleStartDateTimePicker(
                      groupSchedule: groupSchedule,
                      groupScheduleId: groupScheduleId,
                    );
                  },
                );
              },
              padding: EdgeInsets.zero,
              child: Consumer(
                builder: (context, watch, child) {
                  return Text(
                    formatDateTimeExcYear(schedule!.startAt!),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 2,
              ),
              child: Text(
                '~',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return JoinScheduleEndDateTimePicker(
                      groupSchedule: groupSchedule,
                      groupScheduleId: groupScheduleId,
                    );
                  },
                );
              },
              padding: EdgeInsets.zero,
              child: Consumer(
                builder: (context, watch, child) {
                  return Text(
                    formatDateTimeExcYear(schedule!.endAt!),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/schedule/group_member_schedule_provider.dart';
import '../../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import '../../../../utils/time/time_utils.dart';

import 'picker/join_end_picker.dart';
import 'picker/join_start_picker.dart';

class ScheduleJoinTime extends ConsumerStatefulWidget {
  const ScheduleJoinTime({
    super.key,
    required this.groupProfileAndScheduleAndId,
  });

  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;
  @override
  ConsumerState createState() => _ScheduleJoinTimeState();
}

class _ScheduleJoinTimeState extends ConsumerState<ScheduleJoinTime> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.groupProfileAndScheduleAndId.groupSchedule;
    final groupScheduleId =
        widget.groupProfileAndScheduleAndId.groupScheduleId;
        
    final schedule = ref.watch(groupMemberScheduleProvider(groupScheduleId));
    
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
                    return JoinScheduleStartAtPicker(
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
                    return JoinScheduleEndAtPicker(
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

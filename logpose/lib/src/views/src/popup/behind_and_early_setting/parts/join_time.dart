import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/views/src/popup/behind_and_early_setting/parts/picker/join_end_end_picker.dart';

import '../../../../../controllers/providers/group/group_member_schedule_provider.dart';

import '../../../../../models/group/group_profile_with_schedule_with_id_model.dart';

import '../../../../../utils/time/time_utils.dart';

import 'picker/join_start_picker.dart';

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

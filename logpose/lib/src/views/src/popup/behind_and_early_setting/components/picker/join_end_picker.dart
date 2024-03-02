import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../controllers/providers/group/schedule/group_member_schedule_provider.dart';
import '../../../../../../controllers/src/group/update/update_group_member_schedule_setting.dart';

import '../../../../../../models/group/database/group_schedule.dart';

class JoinScheduleEndAtPicker extends ConsumerStatefulWidget {
  const JoinScheduleEndAtPicker({
    super.key,
    required this.groupScheduleId,
    required this.groupSchedule,
  });

  final String groupScheduleId;
  final GroupSchedule groupSchedule;
  @override
  ConsumerState createState() => _JoinScheduleEndAtPickerState();
}

class _JoinScheduleEndAtPickerState
    extends ConsumerState<JoinScheduleEndAtPicker> {
  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.groupScheduleId;
    final groupSchedule = widget.groupSchedule;

    final schedule = ref.watch(groupMemberScheduleProvider(groupScheduleId));
    final scheduleNotifier =
        ref.watch(groupMemberScheduleProvider(groupScheduleId).notifier);

    return Container(
      height: 240,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CupertinoButton(
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  child: const Text(
                    '完了',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (!mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              initialDateTime: schedule!.endAt,
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: schedule.startAt,
              maximumDate: groupSchedule.endAt,
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setEndAt(newDateTime);
                await UpdateGroupMemberSchedule.update(
                  scheduleId: groupScheduleId,
                  endAt: newDateTime,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

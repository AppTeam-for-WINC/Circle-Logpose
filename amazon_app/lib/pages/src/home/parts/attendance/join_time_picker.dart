import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:amazon_app/pages/src/home/parts/attendance/user_schedule_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinScheduleStartDateTimePicker extends ConsumerStatefulWidget {
  const JoinScheduleStartDateTimePicker({
    super.key,
    required this.groupSchedule,
    required this.groupScheduleId,
  });

  final GroupSchedule groupSchedule;
  final String groupScheduleId;
  @override
  ConsumerState createState() => _JoinScheduleStartDateTimePickerState();
}

class _JoinScheduleStartDateTimePickerState
    extends ConsumerState<JoinScheduleStartDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.groupSchedule;
    final groupScheduleId = widget.groupScheduleId;
    final schedule =
        ref.watch(setMemberScheduleProvider(groupScheduleId));
    final scheduleNotifier =
        ref.watch(setMemberScheduleProvider(groupScheduleId).notifier);
    return Container(
      height: 300,
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
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: schedule!.startAt,
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: groupSchedule.startAt,
              maximumDate: groupSchedule.endAt.add(
                const Duration(minutes: -1),
              ),
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setStartAt(newDateTime);
                await GroupMemberScheduleSetting.update(
                  scheduleId: groupScheduleId,
                  startAt: newDateTime,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class JoinScheduleEndDateTimePicker extends ConsumerStatefulWidget {
  const JoinScheduleEndDateTimePicker({
    super.key,
    required this.groupSchedule,
    required this.groupScheduleId,
  });

  final GroupSchedule groupSchedule;
  final String groupScheduleId;
  @override
  ConsumerState createState() => _JoinScheduleEndDateTimePickerState();
}

class _JoinScheduleEndDateTimePickerState
    extends ConsumerState<JoinScheduleEndDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.groupSchedule;
    final groupScheduleId = widget.groupScheduleId;
    final schedule = ref.watch(setMemberScheduleProvider(groupScheduleId));
    final scheduleNotifier =
        ref.watch(setMemberScheduleProvider(groupScheduleId).notifier);
    return Container(
      height: 300,
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
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: schedule!.endAt,
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: schedule.startAt,
              maximumDate: groupSchedule.endAt,
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setEndAt(newDateTime);
                await GroupMemberScheduleSetting.update(
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

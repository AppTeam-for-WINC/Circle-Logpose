import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../controllers/providers/group/schedule/group_member_schedule_provider.dart';

class JoinDatePickerDialog extends ConsumerStatefulWidget {
  const JoinDatePickerDialog({
    super.key,
    required this.startOrEnd,
    required this.groupScheduleId,
    required this.initialDateTime,
    required this.minimumDate,
    required this.maximumDate,
  });

  final String startOrEnd;
  final String groupScheduleId;
  final DateTime initialDateTime;
  final DateTime minimumDate;
  final DateTime maximumDate;

  @override
  ConsumerState createState() => _JoinDatePickerDialogState();
}

class _JoinDatePickerDialogState extends ConsumerState<JoinDatePickerDialog> {
  @override
  Widget build(BuildContext context) {
    final startOrEnd = widget.startOrEnd;
    final groupScheduleId = widget.groupScheduleId;
    final initialDateTime = widget.initialDateTime;
    final minimumDate = widget.minimumDate;
    final maximumDate = widget.maximumDate;
    final scheduleNotifier =
        ref.watch(groupMemberScheduleProvider(groupScheduleId).notifier);

    Future<void> updateJoinTime() async {
      if (startOrEnd == 'start') {
        final startAt =
            ref.read(groupMemberScheduleProvider(groupScheduleId))!.startAt;
        await scheduleNotifier.updateStartAt(startAt);
      } else if (startOrEnd == 'end') {
        final endAt =
            ref.read(groupMemberScheduleProvider(groupScheduleId))!.endAt;
        await scheduleNotifier.updateEndAt(endAt);
      } else {
        throw Exception('Error: Please set start or end.');
      }
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    }

    Future<void> setJoinTime(DateTime newTime) async {
      if (startOrEnd == 'start') {
        await scheduleNotifier.setStartAt(newTime);
      } else if (startOrEnd == 'end') {
        await scheduleNotifier.setEndAt(newTime);
      } else {
        throw Exception('Error: Please set start or end.');
      }
    }

    return Container(
      height: 240,
      color: CupertinoColors.white,
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
                      color: CupertinoColors.activeBlue,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    scheduleNotifier.initSchedule(groupScheduleId);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  onPressed: updateJoinTime,
                  child: const Text(
                    '完了',
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              initialDateTime: initialDateTime,
              backgroundColor: CupertinoColors.white,
              use24hFormat: true,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
              onDateTimeChanged: setJoinTime,
            ),
          ),
        ],
      ),
    );
  }
}

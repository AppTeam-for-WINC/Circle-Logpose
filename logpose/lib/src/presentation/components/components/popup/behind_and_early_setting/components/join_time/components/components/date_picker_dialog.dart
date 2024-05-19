import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../domain/usecase/facade/group_member_schedule_facade.dart';
import '../../../../../../../../notifiers/group_member_schedule_notifier.dart';

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
    final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);

    final memberScheduleController =
        ref.watch(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return const SizedBox.shrink();
    }

    final memberScheduleNotifier = ref.watch(
      groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
    );

    Future<void> updateStartAt() async {
      final startAt = memberScheduleController.startAt;
      await memberScheduleFacade.updateStartAt(groupScheduleId, startAt);
    }

    Future<void> updateEndAt() async {
      final endAt = memberScheduleController.endAt;
      await memberScheduleFacade.updateEndAt(groupScheduleId, endAt);
    }

    void pop() {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    }

    Future<void> updateJoinTime() async {
      if (startOrEnd == 'start') {
        await updateStartAt();
      } else if (startOrEnd == 'end') {
        await updateEndAt();
      } else {
        throw Exception('Error: Please set start or end.');
      }

      pop();
    }

    Future<void> setJoinTime(DateTime newTime) async {
      if (startOrEnd == 'start') {
        await memberScheduleNotifier.setStartAt(newTime);
      } else if (startOrEnd == 'end') {
        await memberScheduleNotifier.setEndAt(newTime);
      } else {
        throw Exception('Error: Please set start or end.');
      }
    }

    Future<void> cancel() async {
      Navigator.of(context).pop();
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
                  onPressed: cancel,
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                      fontSize: 16,
                    ),
                  ),
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

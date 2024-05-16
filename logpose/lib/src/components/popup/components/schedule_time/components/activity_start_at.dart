import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/providers/group/schedule/set_group_schedule_provider.dart';

class ActivityStartAtPicker extends ConsumerStatefulWidget {
  const ActivityStartAtPicker({super.key, this.groupScheduleId});
  final String? groupScheduleId;

  @override
  ConsumerState createState() => _ActivityStartAtPickerState();
}

class _ActivityStartAtPickerState extends ConsumerState<ActivityStartAtPicker> {
  void _cancel() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  void _complete() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleNotifier =
        ref.watch(setGroupScheduleProvider(widget.groupScheduleId).notifier);

    return Container(
      height: 300,
      color: CupertinoColors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CupertinoButton(
                  onPressed: _cancel,
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
                  onPressed: _complete,
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
            height: 200,
            child: CupertinoDatePicker(
              backgroundColor: CupertinoColors.white,
              use24hFormat: true,
              minimumDate: DateTime.now(),
              onDateTimeChanged: (newDateTime) async {
                scheduleNotifier.setStartAt(newDateTime);
              },
            ),
          ),
        ],
      ),
    );
  }
}

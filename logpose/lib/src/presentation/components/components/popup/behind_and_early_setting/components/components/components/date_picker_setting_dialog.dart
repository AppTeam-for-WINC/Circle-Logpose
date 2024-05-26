import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../navigations/pop_navigator.dart';

class DatePickerSettingDialog extends ConsumerStatefulWidget {
  const DatePickerSettingDialog({
    super.key,
    required this.groupScheduleId,
    required this.initialDateTime,
    required this.minimumDate,
    required this.maximumDate,
    required this.updateJoinTime,
    required this.setJoinTime,
  });

  final String groupScheduleId;
  final DateTime initialDateTime;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final Future<void> Function() updateJoinTime;
  final Future<void> Function(DateTime newTime) setJoinTime;

  @override
  ConsumerState createState() => _DatePickerSettingDialogState();
}

class _DatePickerSettingDialogState
    extends ConsumerState<DatePickerSettingDialog> {
  @override
  Widget build(BuildContext context) {
    Future<void> cancel() async {
      PopNavigator(context).pop();
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
                  onPressed: widget.updateJoinTime,
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
              initialDateTime: widget.initialDateTime,
              backgroundColor: CupertinoColors.white,
              use24hFormat: true,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              onDateTimeChanged: widget.setJoinTime,
            ),
          ),
        ],
      ),
    );
  }
}

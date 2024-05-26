import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigations/pop_navigator.dart';

class ActivityTimePicker extends ConsumerStatefulWidget {
  const ActivityTimePicker({
    super.key,
    this.initialDateTime,
    required this.minimumDate,
    required this.onDateTimeChanged,
  });

  final DateTime? initialDateTime;
  final DateTime minimumDate;
  final void Function(DateTime newDateTime) onDateTimeChanged;

  @override
  ConsumerState createState() => _ActivityTimePickerState();
}

class _ActivityTimePickerState extends ConsumerState<ActivityTimePicker> {
  void _cancel() {
    if (mounted) {
      PopNavigator(context).pop();
    }
  }

  void _complete() {
    if (mounted) {
      PopNavigator(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: _cancel,
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  onPressed: _complete,
                  child: const Text(
                    '完了',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: widget.initialDateTime,
              backgroundColor: Colors.white,
              use24hFormat: true,
              minimumDate: widget.minimumDate,
              onDateTimeChanged: widget.onDateTimeChanged,
            ),
          ),
        ],
      ),
    );
  }
}

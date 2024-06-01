import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/time_utils.dart';

import '../../../../navigations/modals/activity_time_picker_navigator.dart';
import '../../../../notifiers/group_schedule_notifier.dart';

class ScheduleActivityTime extends ConsumerStatefulWidget {
  const ScheduleActivityTime({super.key, this.groupScheduleId});
  final String? groupScheduleId;

  @override
  ConsumerState createState() => _ScheduleActivityTimeState();
}

class _ScheduleActivityTimeState extends ConsumerState<ScheduleActivityTime> {
  Future<void> _startAtPopup() async {
    final navigator = ActivityTimePickerNavigator(context);
    await navigator.showModalStartAt(widget.groupScheduleId);
  }

  Future<void> _endAtPopup() async {
    final navigator = ActivityTimePickerNavigator(context);
    await navigator.showModalEndAt(widget.groupScheduleId);
  }

  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

  @override
  Widget build(BuildContext context) {
    final schedule =
        ref.watch(groupScheduleNotifierProvider(widget.groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: const Icon(Icons.schedule, size: 25, color: Colors.grey),
        ),
        CupertinoButton(
          onPressed: _startAtPopup,
          padding: EdgeInsets.zero,
          child: Consumer(
            builder: (context, watch, child) {
              return Text(_formatDateTimeExcYear(schedule.startAt));
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 2),
          child: Text('~', style: TextStyle(fontSize: 24)),
        ),
        CupertinoButton(
          onPressed: _endAtPopup,
          padding: EdgeInsets.zero,
          child: Consumer(
            builder: (context, watch, child) {
              return Text(_formatDateTimeExcYear(schedule.endAt));
            },
          ),
        ),
      ],
    );
  }
}

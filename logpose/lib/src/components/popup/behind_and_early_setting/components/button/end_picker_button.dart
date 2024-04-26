import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/schedule/group_member_schedule_provider.dart';

import '../../../../../models/database/group/group_schedule.dart';
import '../../../../../utils/time/time_utils.dart';
import 'dialog/date_picker_dialog.dart';

class EndPickerButton extends ConsumerStatefulWidget {
  const EndPickerButton({
    super.key,
    required this.groupScheduleId,
    required this.groupSchedule,
  });

  final String groupScheduleId;
  final GroupSchedule groupSchedule;
  @override
  ConsumerState createState() => _EndPickerButtonState();
}

class _EndPickerButtonState extends ConsumerState<EndPickerButton> {
  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.groupScheduleId;
    final groupSchedule = widget.groupSchedule;
    final schedule = ref.watch(groupMemberScheduleProvider(groupScheduleId));

    void showDatePicker() {
      if (schedule == null) {
        return;
      }
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return JoinDatePickerDialog(
            startOrEnd: 'end',
            groupScheduleId: groupScheduleId,
            initialDateTime: schedule.endAt!,
            minimumDate: schedule.startAt!,
            maximumDate: groupSchedule.endAt,
          );
        },
      );
    }

    return CupertinoButton(
      onPressed: showDatePicker,
      padding: EdgeInsets.zero,
      child: Consumer(
        builder: (context, watch, child) {
          return Text(
            formatDateTimeExcYear(schedule!.endAt!),
          );
        },
      ),
    );
  }
}

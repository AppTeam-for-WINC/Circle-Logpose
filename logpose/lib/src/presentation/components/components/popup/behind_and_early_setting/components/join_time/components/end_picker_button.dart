import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../../utils/time/time_utils.dart';

import '../../../../../../../notifiers/group_member_schedule_notifier.dart';

import 'components/date_picker_dialog.dart';

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
  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.groupScheduleId;
    final groupSchedule = widget.groupSchedule;

    final memberSchedule = ref.watch(
      groupMemberScheduleNotifierProvider(groupScheduleId),
    );
    if (memberSchedule == null) {
      return const SizedBox.shrink();
    }

    void showDatePicker() {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return JoinDatePickerDialog(
            startOrEnd: 'end',
            groupScheduleId: groupScheduleId,
            initialDateTime: memberSchedule.endAt!,
            minimumDate: memberSchedule.startAt!,
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
          return Text(_formatDateTimeExcYear(memberSchedule.endAt!));
        },
      ),
    );
  }
}

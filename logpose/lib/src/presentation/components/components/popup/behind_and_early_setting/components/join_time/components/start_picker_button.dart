import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../../domain/providers/group/schedule/group_member_schedule_provider.dart';

import '../../../../../../../../utils/time/time_utils.dart';

import 'components/date_picker_dialog.dart';

class StartPickerButton extends ConsumerStatefulWidget {
  const StartPickerButton({
    super.key,
    required this.groupScheduleId,
    required this.groupSchedule,
  });

  final String groupScheduleId;
  final GroupSchedule groupSchedule;
  @override
  ConsumerState createState() => _StartPickerButtonState();
}

class _StartPickerButtonState extends ConsumerState<StartPickerButton> {
  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

  @override
  Widget build(BuildContext context) {
    final groupScheduleId = widget.groupScheduleId;
    final groupSchedule = widget.groupSchedule;

    final schedule = ref.watch(groupMemberScheduleProvider(groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    void showDatePicker() {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return JoinDatePickerDialog(
            startOrEnd: 'start',
            groupScheduleId: groupScheduleId,
            initialDateTime: schedule.startAt!,
            minimumDate: groupSchedule.startAt,
            maximumDate: groupSchedule.endAt.add(
              const Duration(minutes: -1),
            ),
          );
        },
      );
    }

    return CupertinoButton(
      onPressed: showDatePicker,
      padding: EdgeInsets.zero,
      child: Consumer(
        builder: (context, watch, child) {
          return Text(_formatDateTimeExcYear(schedule.startAt!));
        },
      ),
    );
  }
}

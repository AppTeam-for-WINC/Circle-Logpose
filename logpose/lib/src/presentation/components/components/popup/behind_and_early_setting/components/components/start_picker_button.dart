import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../utils/time_utils.dart';

import '../../../../../../handlers/start_picker_button_handler.dart';
import '../../../../../../navigations/modals/to_date_picker_setting_dialog_navigator.dart';
import '../../../../../../notifiers/group_member_schedule_notifier.dart';

class StartPickerButton extends ConsumerStatefulWidget {
  const StartPickerButton({
    super.key,
    required this.groupScheduleId,
    required this.groupSchedule,
    required this.textSize,
  });

  final String groupScheduleId;
  final GroupSchedule groupSchedule;
  final double textSize;

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

    final memberScheduleController =
        ref.watch(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return const SizedBox.shrink();
    }

    Future<void> updateJoinTime() async {
      final memberScheduleController =
          ref.watch(groupMemberScheduleNotifierProvider(groupScheduleId));
      final handler = StartPickerButtonHandler(
        context: context,
        ref: ref,
        groupScheduleId: groupScheduleId,
        memberScheduleId: memberScheduleController!.scheduleId,
        startAt: memberScheduleController.startAt,
      );
      await handler.updateJoinTime();
    }

    Future<void> setJoinTime(DateTime newTime) async {
      final handler = StartPickerButtonHandler(
        context: context,
        ref: ref,
        groupScheduleId: groupScheduleId,
        memberScheduleId: memberScheduleController.scheduleId,
        startAt: memberScheduleController.startAt,
      );
      await handler.setJoinTime(newTime);
    }

    Future<void> handleModal() async {
      final navigator = ToDatePickerSettingDialogNavigator(context);
      await navigator.showModal(
        groupScheduleId: groupScheduleId,
        initialDateTime: memberScheduleController.startAt!,
        minimumDate: groupSchedule.startAt,
        maximumDate: groupSchedule.endAt.add(const Duration(minutes: -1)),
        updateJoinTime: updateJoinTime,
        setJoinTime: setJoinTime,
      );
    }

    return CupertinoButton(
      onPressed: handleModal,
      padding: EdgeInsets.zero,
      child: Consumer(
        builder: (context, watch, child) {
          return Text(
            _formatDateTimeExcYear(memberScheduleController.startAt!),
            style: TextStyle(
              fontSize: widget.textSize,
            ),
          );
        },
      ),
    );
  }
}

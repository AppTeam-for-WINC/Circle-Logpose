import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../utils/time/time_utils.dart';

import '../../../../../../handlers/end_picker_button_handler.dart';
import '../../../../../../navigations/modals/time_picker_button_modal_navigator.dart';
import '../../../../../../notifiers/group_member_schedule_notifier.dart';

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

    final memberScheduleController =
        ref.watch(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return const SizedBox.shrink();
    }

    Future<void> updateJoinTime() async {
      final memberScheduleController =
          ref.watch(groupMemberScheduleNotifierProvider(groupScheduleId));
      final handler = EndPickerButtonHandler(
        context: context,
        ref: ref,
        groupScheduleId: groupScheduleId,
        memberScheduleId: memberScheduleController!.scheduleId,
        endAt: memberScheduleController.endAt,
      );
      await handler.updateJoinTime();
    }

    Future<void> setJoinTime(DateTime newTime) async {
      final handler = EndPickerButtonHandler(
        context: context,
        ref: ref,
        groupScheduleId: groupScheduleId,
        memberScheduleId: memberScheduleController.scheduleId,
        endAt: memberScheduleController.endAt,
      );
      await handler.setJoinTime(newTime);
    }

    Future<void> handleModal() async {
      final navigator = TimePickerButtonModalNavigator(
        context: context,
        groupScheduleId: groupScheduleId,
        initialDateTime: memberScheduleController.endAt!,
        minimumDate: memberScheduleController.startAt!,
        maximumDate: groupSchedule.endAt,
        updateJoinTime: updateJoinTime,
        setJoinTime: setJoinTime,
      );

      await navigator.showModal();
    }

    return CupertinoButton(
      onPressed: handleModal,
      padding: EdgeInsets.zero,
      child: Consumer(
        builder: (context, watch, child) {
          return Text(_formatDateTimeExcYear(memberScheduleController.endAt!));
        },
      ),
    );
  }
}

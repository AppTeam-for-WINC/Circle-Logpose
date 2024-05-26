import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/providers/text_field/schedule_detail_controller_provider.dart';
import '../../../../../domain/providers/text_field/schedule_place_controller_provider.dart';
import '../../../../../domain/providers/text_field/schedule_title_controller_provider.dart';

import '../../../../handlers/schedule_setting_save_button_handler.dart';
import '../../../../notifiers/group_schedule_notifier.dart';

enum ActionType { create, update }

class ScheduleSettingSaveButton extends ConsumerStatefulWidget {
  const ScheduleSettingSaveButton({
    super.key,
    this.defaultGroupId,
    this.groupScheduleId,
    required this.actionType,
  });

  final String? defaultGroupId;
  final String? groupScheduleId;
  final ActionType actionType;

  @override
  ConsumerState createState() => _ScheduleSettingSaveButtonState();
}

class _ScheduleSettingSaveButtonState
    extends ConsumerState<ScheduleSettingSaveButton> {
  @override
  Widget build(BuildContext context) {
    final defaultGroupId = widget.defaultGroupId;
    final groupScheduleId = widget.groupScheduleId;

    final schedule = ref.watch(
      groupScheduleNotifierProvider(groupScheduleId),
    );
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    ScheduleSettingSaveButtonHandler setHandler() {
      return ScheduleSettingSaveButtonHandler(
        context: context,
        ref: ref,
        groupId: schedule.groupId,
        defaultGroupId: defaultGroupId,
        groupScheduleId: groupScheduleId,
        title: ref.read(scheduleTitleControllerProvider).text,
        color: schedule.color,
        place: ref.read(schedulePlaceControllerProvider).text,
        detail: ref.read(scheduleDetailControllerProvider).text,
        startAt: schedule.startAt,
        endAt: schedule.endAt,
      );
    }

    Future<void> handleToCreateSchedule() async {
      final handler = setHandler();
      await handler.handleToCreateSchedule();
    }

    Future<void> handleToUpdateSchedule() async {
      final handler = setHandler();
      await handler.handleToUpdateSchedule();
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.actionType == ActionType.create
          ? handleToCreateSchedule
          : handleToUpdateSchedule,
      child: const Text(
        '保存',
        style: TextStyle(color: CupertinoColors.white, fontSize: 16),
      ),
    );
  }
}